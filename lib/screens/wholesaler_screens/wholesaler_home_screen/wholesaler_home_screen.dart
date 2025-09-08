import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/controller/retailer_notification_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/controller/wholesaler_order_history_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/wholesaler_order_history.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_profile_screen/controller/wholesaler_profile_screen_controller.dart';
import 'package:inventory_app/screens/widgets/home_list_widget.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_invitelink.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/text_button_widget/text_button_widget.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_images_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class WholesalerHomeScreen extends StatefulWidget {
  const WholesalerHomeScreen({super.key});

  @override
  State<WholesalerHomeScreen> createState() => _WholesalerHomeScreenState();
}

class _WholesalerHomeScreenState extends State<WholesalerHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(WholesalerOrderHistoryController());
    Get.find<WholesalerOrderHistoryController>().initialize();
    Get.put(NotificationsController());
    Get.find<NotificationsController>().getNotificationsRepo();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the RetailerProfileScreenController is initialized
    final profileController = Get.put(WholesalerProfileScreenController());

    final controller = NotificationsController.instance;

    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: Column(
        children: [
          MainAppbarWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display image from controller dynamically
                    Obx(() {
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: profileController
                                .image.value.isNotEmpty
                            ? NetworkImage(
                                "${Urls.socketUrl}${profileController.image.value}")
                            : const AssetImage(
                                AppImagesPath.profileImage,
                              ),
                        onBackgroundImageError: (exception, stackTrace) =>
                            const AssetImage(AppImagesPath.profileImage),
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
                        Get.toNamed(AppRoutes.wholesalerNotificationScreen);

                        appLogger(
                            "message ${NotificationsController.instance.unreadMessage.value}");
                        NotificationsController.instance.unreadMessage.clear();
                      },
                      icon: Obx(() {
                        return Badge(
                          isLabelVisible: NotificationsController
                              .instance.unreadMessage.value.isNotEmpty,
                          label: Text(
                            "${NotificationsController.instance.unreadMessage.value.length}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                  Obx(
                    () => CustomContainerWidget(
                      isWholesaler: true,
                      onTap: () {
                        final control = Get.find<BottomNavbarController>();
                        control.changeIndex(1);
                        // Get.to(WholesalerOrderHistoryScreen(initialTabIndex: 0));
                      },
                      containerColor: AppColors.lightestBlue,
                      icon: AppIconsPath.orderIcon,
                      text: AppStrings.newOrder,
                      numberOfOrder:
                          Get.find<WholesalerOrderHistoryController>()
                              .newOrders
                              .length,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  Obx(
                    () => CustomContainerWidget(
                      isWholesaler: true,
                      onTap: () {
                        final control = Get.find<BottomNavbarController>();
                        control.changeIndex(2);
                      },
                      containerColor: AppColors.lightYellow,
                      icon: AppIconsPath.wholeSellerListIcon,
                      text: AppStrings.pendingOrder,
                      numberOfOrder:
                          Get.find<WholesalerOrderHistoryController>()
                              .pendingOrders
                              .length,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 16),
                  Obx(
                    () => CustomContainerWidget(
                      isWholesaler: true,
                      onTap: () {
                        Get.to(const WholesalerOrderHistoryScreen(
                            initialTabIndex: 2));
                        final control = Get.find<BottomNavbarController>();
                        control.changeIndex(2);
                      },
                      containerColor: AppColors.purpleLight,
                      icon: AppIconsPath.orderHistoryIcon,
                      text: AppStrings.confirmedOrder,
                      numberOfOrder:
                          Get.find<WholesalerOrderHistoryController>()
                              .confirmedOrders
                              .length,
                    ),
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
                          AppCommonFunction.invite();
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
                        text: AppStrings.toInviteWholesaler,
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
    );
  }
}
