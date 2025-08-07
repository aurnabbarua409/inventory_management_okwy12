import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_settings_screen/controller/retailer_setting_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_settings_screen/widget/retailer_setting_item.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

class RetailerSettingsScreen extends StatelessWidget {
  const RetailerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: AppStrings.settings,
        centerTitle: true,
        leading: IconButtonWidget(
          onTap: () {
            final control = Get.find<BottomNavbarController>();
            control.changeIndex(0);
          },
          icon: AppIconsPath.backIcon,
          color: AppColors.black,
          size: ResponsiveUtils.width(22),
        ),
      ),
      body: GetBuilder(
        init: RetailerSettingController(),
        builder: (controller) => ListView(
          children: [
            const SpaceWidget(spaceHeight: 28),
            RetailerSettingItem(
              leading: AppIconsPath.profile,
              title: AppStrings.profile,
              onTap: controller.profile,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.pass,
              title: AppStrings.password,
              onTap: controller.changePassword,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.about,
              title: AppStrings.aboutUs,
              onTap: controller.about,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.contact,
              title: AppStrings.contactUs,
              onTap: controller.contact,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.faq,
              title: AppStrings.fAq,
              onTap: controller.faq,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.terms,
              title: AppStrings.termsCondition,
              onTap: controller.termAndCondition,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.invite,
              title: AppStrings.invites,
              onTap: controller.share,
            ),
            const SpaceWidget(spaceHeight: 10),
            RetailerSettingItem(
              leading: AppIconsPath.logout,
              title: AppStrings.logOut,
              onTap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
