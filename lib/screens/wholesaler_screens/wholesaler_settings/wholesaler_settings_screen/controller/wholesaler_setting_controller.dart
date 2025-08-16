import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:share_plus/share_plus.dart';

class WholesalerSettingController extends GetxController {
  void logout() {
    PrefsHelper.emailId = "";
    PrefsHelper.token = "";
    PrefsHelper.userRole = "";
    PrefsHelper.removeAllPrefData();
    PrefsHelper.isLogIn = false;
    PrefsHelper.setBool('isLogIn', false);
    Get.toNamed(AppRoutes.onboardingScreen);
  }

  void share() {
    Share.share(AppStrings.shareAppFromRetailer);
  }

  void termAndCondition() {
    Get.toNamed(AppRoutes.retailerTerms);
  }

  void faq() {
    Get.toNamed(AppRoutes.retailerFaq);
  }

  void contact() {
    Get.toNamed(AppRoutes.retailerContact);
  }

  void about() {
    Get.toNamed(AppRoutes.about);
  }

  void notification() {
    Get.toNamed(AppRoutes.wholesalerNotificationScreen);
  }

  void changePassword() {
    Get.toNamed(AppRoutes.wholesalerChangePasswordScreen);
  }

  void subscription() {
    Get.toNamed(AppRoutes.subscriptionScreen);
  }

  void profile() {
    Get.toNamed(AppRoutes.wholesalerProfileScreen);
  }

  void logoutCOnfirm(BuildContext context) {
    showCustomPopup(
      context,
      [
        const Center(
          child: Text(
            "Are you sure?",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            "Do you really want to logout?",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text("No", style: TextStyle(color: AppColors.red)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue),
              child: const Text(
                "Yes",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
