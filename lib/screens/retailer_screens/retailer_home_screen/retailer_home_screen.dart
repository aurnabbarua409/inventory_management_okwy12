import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/controller/retailer_notification_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_profile_screen/controller/retailer_profile_screen_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_saved_order_screen/controller/retailer_saved_order_screen_controller.dart';
import 'package:inventory_app/screens/widgets/home_list_widget.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_button_widget/text_button_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:share_plus/share_plus.dart';

class RetailerHomeScreen extends StatelessWidget {
  const RetailerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileController = Get.put(ProfileScreenController());

    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: GetBuilder(
        init: ProfileScreenController(),
        builder: (profileController) => Column(
          children: [
            MainAppbarWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return CircleAvatar(
                          radius: 20,
                          backgroundImage: profileController
                                  .image.value.isNotEmpty
                              ? NetworkImage(
                                  "${Urls.socketUrl}${profileController.image.value}")
                              : const AssetImage(AppImagesPath.profileImage),
                          // child: ImageWidget(
                          //   height: 40,
                          //   width: 40,
                          //   fromNetwork:
                          //       profileController.image.value.isNotEmpty,
                          //   imagePath: profileController.image.value.isNotEmpty
                          //       ? profileController
                          //           .image.value // Pass URL string directly
                          //       : AppImagesPath
                          //           .profileImage, // Default profile image if empty
                          // ),
                        );
                      }),
                      const TextWidget(
                        text: "",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.retailerNotification);
                        },
                        icon: Obx(() {
                          return Badge(
                            isLabelVisible: true,
                            label: Text(
                              "${NotificationsController.instance.unreadMessage.value}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: AppColors.extremelyRed,
                            child: const IconWidget(
                              height: 24,
                              width: 24,
                              icon: AppIconsPath.notificationIcon,
                              color: AppColors.white,
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  const SpaceWidget(spaceHeight: 6),
                  Obx(
                    () => TextWidget(
                      text: "Hi, ${profileController.userName.value}",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.white,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  const TextWidget(
                    text: AppStrings.hiDesc,
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    fontColor: AppColors.white,
                    textAlignment: TextAlign.left,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SpaceWidget(spaceHeight: 36),
                    CustomContainerWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.retailerCreateNewOrderScreen);
                      },
                      containerColor: AppColors.lightestBlue,
                      icon: AppIconsPath.orderIcon,
                      text: AppStrings.createNewOrder,
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    CustomContainerWidget(
                      onTap: () {
                        // Register the controller before navigating to the screen

                        Get.put(RetailerSavedOrderScreenController());
                        // Register the controller
                        Get.toNamed(AppRoutes.retailerSavedOrderScreen);

                        // Navigate to the screen
                      },
                      containerColor: AppColors.lightYellow,
                      icon: AppIconsPath.wholeSellerListIcon,
                      text: AppStrings.viewSavedList,
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    CustomContainerWidget(
                      onTap: () {
                        // Get.toNamed(AppRoutes.retailerOrderHistoryScreen);
                        final control = Get.find<BottomNavbarController>();
                        control.changeIndex(2);
                      },
                      containerColor: AppColors.purpleLight,
                      icon: AppIconsPath.orderHistoryIcon,
                      text: AppStrings.orderHistory,
                    ),
                    const SpaceWidget(spaceHeight: 72),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 2,
                      runSpacing: -2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const IconWidget(
                          height: 18,
                          width: 18,
                          icon: AppIconsPath.shareIcon,
                        ),
                        const SpaceWidget(spaceWidth: 4),
                        TextButtonWidget(
                          onPressed: () {
                            Share.share(
                              AppStrings.shareAppFromRetailer,
                              subject: 'Flutter Share Example',
                            );
                          },
                          text: AppStrings.clickHere,
                          textColor: AppColors.primaryBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryBlue,
                        ),
                        const SpaceWidget(spaceWidth: 4),
                        const TextWidget(
                          text: AppStrings.toInvite,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontColor: AppColors.black,
                          textAlignment: TextAlign.left,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
