import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/api_response_model.dart';
import 'package:inventory_app/models/notification/notification_model.dart';
import 'package:inventory_app/models/notification/socket_notification_model.dart';
import 'package:inventory_app/services/api_service.dart';

import 'package:inventory_app/services/socket_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notificationModel = <NotificationModel>[].obs;
  RxInt unreadMessage = 0.obs;
  Rx<Status> status =
      Status.loading.obs; // Make status observable using Rx<Status>
  Timer? refreshTimer;
  @override
  void onInit() {
    super.onInit();    
    getNotificationsRepo();
    listenToNewNotification();
    refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getNotificationsRepo(); // repeat fetch
    });
  }

  @override
  void onClose() {
    super.onClose();
  }


  // Listen to New Notifications via socket
  void listenToNewNotification() async {
    String id = await PrefsHelper.getString(PrefsHelper.userId);
    if (id.isEmpty) {
      id = PrefsHelper.userId;
    }

    appLogger(
        "===================================Notification userId : $id==============================================");

    try {
      SocketApi.socket.on("get-notification::$id", (data) {
        appLogger("Socket Res=================>>>>>>>>>>>>>$data");

        if (data != null) {
          SocketNotificationModel newNotification = SocketNotificationModel.fromJson(data);

          debugPrint("New notification received: $newNotification");

          // notificationModel.insert(0, newNotification);
          // notificationModel.refresh();
          // unreadMessage.value++;
          unreadMessage.value += 1;
          appLogger("unread notification value: ${unreadMessage.value}");
          if (!newNotification.isRead) {
            unreadMessage.value += 1;
            unreadMessage.refresh();
          }

          update();
        } else {
          appLogger("Received null data for notifications");
        }
      });
    } catch (e) {
      appLogger(e);
    }
  }

  // Fetch notifications from the repository
  void getNotificationsRepo() async {
    // if (status.value == Status.loading) return;
    // status.value = Status.loading;
    update();

    try {
      status.value = Status.loading;
      update();
      var response = await ApiService.getApi(Urls.getNotification);
      debugPrint("API Response: $response");
      appLogger(response);

      if (response != null && response['data'] != null) {
        // Map the response data to NotificationModel objects
        notificationModel.assignAll(
          (response['data'] as List)
              .map((json) => NotificationModel.fromJson(json))
              .toList(),
        );

        status.value = Status
            .completed; // Set status to completed after successful data fetch
      } else {
        status.value =
            Status.error; // Set status to error if the response is invalid
        snackBar("Error", "Failed to load notifications");
      }
    } catch (e) {
      status.value =
          Status.error; // Set status to error in case of an exception
      snackBar("Error", "An error occurred while fetching notifications");
      debugPrint("Error: $e");
    }

    update();
  }

  // Mark Notification as Read
  Future<void> markNotificationAsRead(String notificationId) async {
    String url = '${Urls.getNotification}/$notificationId';

    // Map<String, dynamic> body = {'isRead': true};

    try {
      var response = await ApiService.patchApi(url, {});

      if (response != null && response['success'] == true) {
        // Find the notification in the observable list
        NotificationModel? notification = notificationModel.firstWhere(
          (item) => item.id == notificationId,
          orElse: () => NotificationModel(
              id: '',
              sender: '',
              receiver: '',
              message: '',
              isRead: false,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0),
        );

        if (notification.id.isNotEmpty) {
          // Mark the notification as read locally
          notification.isRead = true;

          // Refresh the observable list to update the UI
          notificationModel.refresh();

          // If the notification was unread, decrement the unreadMessage count
          if (!notification.isRead) {
            unreadMessage.value -= 1;
            notificationModel.refresh(); // Refresh RxList
            unreadMessage.refresh(); // Refresh RxInt
            update(); // Ensure GetBuilder rebuilds
          }
        }

        update(); // Ensure the UI is updated
      } else {
        debugPrint(
            'Failed to mark notification as read: ${response['message']}');
        Get.snackbar('Error', 'Failed to mark notification as read');
      }
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar(
          'Error', 'An error occurred while marking the notification as read');
    }
  }

  // Helper function for displaying snackbars
  void snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  static NotificationsController get instance =>
      Get.put(NotificationsController());

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} sec ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    }
  }
}
