import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RetailerSettingsScreen extends StatelessWidget {
  const RetailerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: AppStrings.settings,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
      ),
      body: ListView(
        children: [
          const SpaceWidget(spaceHeight: 28),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.profile,
            title: AppStrings.profile,
            onTap: () {
              Get.toNamed(AppRoutes.retailerProfile);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.pass,
            title: AppStrings.password,
            onTap: () {
              Get.toNamed(AppRoutes.changePassword);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.about,
            title: AppStrings.aboutUs,
            onTap: () {
              Get.toNamed(AppRoutes.about); // Navigate to Profile screen
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.contact,
            title: AppStrings.contactUs,
            onTap: () {
              Get.toNamed(AppRoutes.retailerContact);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.faq,
            title: AppStrings.fAq,
            onTap: () {
              Get.toNamed(AppRoutes.retailerFaq);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.terms,
            title: AppStrings.termsCondition,
            onTap: () {
              Get.toNamed(AppRoutes.retailerTerms);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.invite,
            title: AppStrings.invites,
            onTap: () {
              Get.toNamed(AppRoutes.invite);
            },
          ),
          const SpaceWidget(spaceHeight: 10),
          _buildSettingsItem(
            context,
            leading: AppIconsPath.logout,
            title: AppStrings.logOut,
            onTap: () {
              Get.toNamed(AppRoutes.onboardingScreen);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String leading, // Allow custom widgets for leading
    required String title,
    required VoidCallback onTap,
  }) {
    appLogger("in setting: $title");
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconWidget(
                  height: 24,
                  width: 24,
                  icon: leading,
                  color: AppColors.black,
                ),
                const SpaceWidget(spaceWidth: 20),
                TextWidget(
                  text: title,
                  fontSize: 16,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            if (title == AppStrings.logOut)
              const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
