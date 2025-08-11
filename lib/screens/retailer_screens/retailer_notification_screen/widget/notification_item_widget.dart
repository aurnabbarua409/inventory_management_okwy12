import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/models/notification/notification_model.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/controller/retailer_notification_controller.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    // Date formatting to display only the date in a user-friendly format
    String formattedDate =
        "${item.createdAt.year}-${item.createdAt.month}-${item.createdAt.day}";

    return GestureDetector(
      onTap: () {
        // Mark notification as read when tapped
        Get.find<NotificationsController>().markNotificationAsRead(item.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryBlue),
        ),
        child: Row(
          children: [
            // Notification Avatar
            const CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 35,
              child: ClipOval(
                child: Icon(
                  Icons.date_range,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Date row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextWidget(
                          text: item.message,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                          fontColor: AppColors.black,
                        ),
                      ),
                      TextWidget(
                        text: formattedDate, // Display formatted date
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  // Message Text
                  TextWidget(
                    text: item.message, // Display the message
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    maxLines: 2, fontColor: AppColors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
