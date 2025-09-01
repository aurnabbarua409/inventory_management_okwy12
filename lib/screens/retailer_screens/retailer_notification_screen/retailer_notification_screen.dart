import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/api_response_model.dart';
import 'package:inventory_app/models/notification/notification_model.dart';
import 'package:inventory_app/screens/widgets/no_data_widget.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/controller/retailer_notification_controller.dart';

class RetailerNotificationScreen extends StatefulWidget {
  const RetailerNotificationScreen({super.key});

  @override
  State<RetailerNotificationScreen> createState() =>
      _RetailerNotificationScreenState();
}

class _RetailerNotificationScreenState
    extends State<RetailerNotificationScreen> {
  final controller = NotificationsController.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getNotificationsRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: AppbarWidget(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.getNotificationsRepo();
            Get.back();
          },
        ),
        text: AppStrings.notification,
        centerTitle: true,
        action: IconButton(
            onPressed: () {
              controller.getNotificationsRepo();
            },
            icon: const Icon(Icons.refresh)),
      ),
      body: SafeArea(
        child: Obx(() {
          switch (controller.status.value) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                child: ElevatedButton(
                  onPressed: controller.getNotificationsRepo,
                  child: const Text('Retry'),
                ),
              );
            case Status.completed:
              return controller.notificationModel.isEmpty
                  ? const NoData()
                  : RefreshIndicator(
                      onRefresh: () async {
                        controller.getNotificationsRepo();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.all(ResponsiveUtils.width(16)),
                              child: TextWidget(
                                text: AppStrings.today,
                                fontColor: AppColors.aquaBlue,
                                fontSize: ResponsiveUtils.width(14),
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                              ),
                            ),
                            ..._buildNotifications(controller, isToday: true),
                            Padding(
                              padding:
                                  EdgeInsets.all(ResponsiveUtils.width(16)),
                              child: TextWidget(
                                text: AppStrings.yesterday,
                                fontColor: AppColors.aquaBlue,
                                fontSize: ResponsiveUtils.width(14),
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                              ),
                            ),
                            ..._buildNotifications(controller, isToday: false),
                          ],
                        ),
                      ),
                    );
            default:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }

  // Function to build notifications based on whether they are 'Today' or 'Yesterday'
  List<Widget> _buildNotifications(NotificationsController controller,
      {required bool isToday}) {
    // Filter the notifications for today or yesterday
    List<NotificationModel> filteredNotifications = controller.notificationModel
        .where((notification) => _isToday(notification, isToday))
        .toList();

    // If there are no notifications for today or yesterday, display a message
    if (filteredNotifications.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: TextWidget(
              text: isToday
                  ? "No new notifications for Today"
                  : "No new notifications for Yesterday",
              fontColor: AppColors.onyxBlack,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.center,
            ),
          ),
        ),
      ];
    }

    // Otherwise, build the list of notifications
    return filteredNotifications.map((notification) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            // Mark notification as read when tapped
            controller.markNotificationAsRead(notification.id);
          },
          child: Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Show icon based on whether the notification is read
                  notification.isRead
                      ? const IconWidget(
                          icon: AppIconsPath.alert2,
                          width: 44,
                          height: 44,
                        )
                      : const IconWidget(
                          icon: AppIconsPath.alert1,
                          width: 44,
                          height: 44,
                        ),
                  const SpaceWidget(spaceWidth: 12),
                  // Wrap the column with Expanded to prevent overflow
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: notification.message,
                          fontColor: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlignment: TextAlign.start,
                        ),
                        const SpaceWidget(spaceHeight: 8),
                        TextWidget(
                          text: controller.timeAgo(notification.createdAt),
                          fontColor: AppColors.onyxBlack,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlignment: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  // Helper function to determine if a notification is from today or yesterday
  bool _isToday(NotificationModel notification, bool isToday) {
    final today = DateTime.now();
    final notificationDate = notification.createdAt;
    final yesterday = today.subtract(const Duration(days: 1));

    if (isToday) {
      return notificationDate.year == today.year &&
          notificationDate.month == today.month &&
          notificationDate.day == today.day;
    } else {
      return notificationDate.year == yesterday.year &&
          notificationDate.month == yesterday.month &&
          notificationDate.day == yesterday.day;
    }
  }
}
