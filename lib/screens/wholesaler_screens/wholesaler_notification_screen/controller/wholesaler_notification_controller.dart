// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:inventory_app/helpers/prefs_helper.dart';
// import 'package:inventory_app/models/api_response_model.dart';
// import 'package:inventory_app/services/api_service.dart';
// import 'package:inventory_app/services/socket_service.dart';
// import 'package:inventory_app/utils/app_urls.dart';

// RxInt unreadMessage = 0.obs;

// RxList<NotificationDatum> notificationModel = <NotificationDatum>[].obs;
// Rx<Notification> unReadModel = Notification().obs;

// ///========================= Listen to Socket =======================

// listenToNewNotification() async {
//   String id = await PrefsHelper.getString(PrefsHelper.userId);

//   SocketApi.socket.on("NewNotification::$id", (data) {
//     // debugPrint("Socket Res=================>>>>>>>>>>>>>$data");

//     try {
//       if (data != null) {
//         NotificationModel unreadNotification = NotificationModel.fromJson(data);
//         NotificationDatum newNotification = NotificationDatum.fromJson(data);

//         getNotification();

//         notificationModel.insert(0, newNotification);
//         notificationModel.refresh();

//         if (unreadNotification.data?.unRead != null &&
//             unreadNotification.data?.unRead != 0) {
//           unreadMessage.value = unreadNotification.data!.unRead!.toInt();

//           unreadMessage.refresh();

//           update();
//           debugPrint(
//               "-===--=-=-=-=-=-=-=-=-=-=-= this is unread ${unreadNotification.data!.unRead!.toString()}");
//         }

//         update();
//       } else {
//         debugPrint("Received null data for patient-notifications");
//       }
//     } catch (e) {
//       debugPrint("Error processing patient-notifications: $e");
//     }
//   });
// }

// ///<====================== This is for get notification ====================>

// Future<void> getNotification() async {
//   Status.loading;
//   var response = await ApiService.getApi(Urls.getNotification);
//   if (response != null) {
//     unReadModel.value = Notification.fromJson(response.body);
//     notificationModel.value = List<Notification>.from(
//         response.body["data"]["result"].map((x) => Notification.fromJson(x)));

//     if (notificationModel.isNotEmpty) {
//       // currentPage.value = response.body["pagination"]['currentPage'];
//       // totalPage.value = response.body["pagination"]['totalPage'];
//     }
//     notificationModel.refresh();
//     debugPrint(
//         "===============----------------- ================== ---------------==== This is unread message");
//     Status.completed;
//   } else {
//     if (response.statusText == ErrorWidget) {
    
//     } else {
//       (Status.error);
//     }
//     return;
//   }
// }
