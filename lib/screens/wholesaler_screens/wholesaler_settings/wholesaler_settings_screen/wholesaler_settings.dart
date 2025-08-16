import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_settings_screen/controller/wholesaler_setting_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_settings_screen/widget/wholesaler_setting_item.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';

class WholesalerSettings extends StatelessWidget {
  const WholesalerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        text: AppStrings.settings,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final control = Get.find<BottomNavbarController>();
            control.changeIndex(0);
          },
        ),
      ),
      body: GetBuilder(
        init: WholesalerSettingController(),
        builder: (controller) => ListView(
          children: [
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.profile, width: 24, height: 24),
              title: AppStrings.profile,
              onTap: controller.profile,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.subscon, width: 24, height: 24),
              title: AppStrings.subscription,
              onTap: controller.subscription,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.pass, width: 24, height: 24),
              title: AppStrings.password,
              onTap: controller.changePassword,
            ),
            WholesalerSettingItem(
              leading: SvgPicture.asset(AppIconsPath.notification,
                  width: 24, height: 24),
              title: AppStrings.notification,
              onTap: controller.notification,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.about, width: 24, height: 24),
              title: AppStrings.aboutUs,
              onTap: controller.about,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.contact, width: 24, height: 24),
              title: AppStrings.contactUs,
              onTap: controller.contact,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.faq, width: 24, height: 24),
              title: AppStrings.fAq,
              onTap: controller.faq,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.terms, width: 24, height: 24),
              title: AppStrings.termsCondition,
              onTap: controller.termAndCondition,
            ),
            WholesalerSettingItem(
              leading:
                  SvgPicture.asset(AppIconsPath.invite, width: 24, height: 24),
              title: AppStrings.invites,
              onTap: controller.share,
            ),
            WholesalerSettingItem(
                leading: SvgPicture.asset(AppIconsPath.logout,
                    width: 24, height: 24),
                title: AppStrings.logOut,
                onTap: () {
                  controller.logoutCOnfirm(context);
                }),
          ],
        ),
      ),
    );
  }
}
