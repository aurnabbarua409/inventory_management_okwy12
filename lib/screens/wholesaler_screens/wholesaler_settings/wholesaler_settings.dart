import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';

class WholesalerSettings extends StatelessWidget {
  const WholesalerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        text: AppStrings.settings,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Get.toNamed(AppRoutes.wholesalerHomeScreen);
        //   },
        // ),
      ),
      body: ListView(
        children: [
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.profile, width: 24, height: 24),
            title: AppStrings.profile,
            onTap: () {
              Get.toNamed(AppRoutes.wholesalerProfileScreen);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.subscon, width: 24, height: 24),
            title: AppStrings.subscription,
            onTap: () {
              Get.toNamed(AppRoutes.subscriptionScreen);
            },
          ),
          _buildSettingsItem(
            leading: SvgPicture.asset(AppIconsPath.pass, width: 24, height: 24),
            title: AppStrings.password,
            onTap: () {
              Get.toNamed(AppRoutes.wholesalerChangePasswordScreen);
            },
          ),
          _buildSettingsItem(
            leading: SvgPicture.asset(AppIconsPath.notification,
                width: 24, height: 24),
            title: AppStrings.notification,
            onTap: () {
              Get.toNamed(AppRoutes.wholesalerNotificationScreen);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.about, width: 24, height: 24),
            title: AppStrings.aboutUs,
            onTap: () {
              Get.toNamed(AppRoutes.about);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.contact, width: 24, height: 24),
            title: AppStrings.contactUs,
            onTap: () {
              Get.toNamed(AppRoutes.retailerContact);
            },
          ),
          _buildSettingsItem(
            leading: SvgPicture.asset(AppIconsPath.faq, width: 24, height: 24),
            title: AppStrings.fAq,
            onTap: () {
              Get.toNamed(AppRoutes.retailerFaq);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.terms, width: 24, height: 24),
            title: AppStrings.termsCondition,
            onTap: () {
              Get.toNamed(AppRoutes.retailerTerms);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.invite, width: 24, height: 24),
            title: AppStrings.invites,
            onTap: () {
              Get.toNamed(AppRoutes.invite);
            },
          ),
          _buildSettingsItem(
            leading:
                SvgPicture.asset(AppIconsPath.logout, width: 24, height: 24),
            title: AppStrings.logOut,
            onTap: () {
              Get.toNamed(AppRoutes.onboardingScreen);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required Widget leading,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: leading,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: title == AppStrings.logOut
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
