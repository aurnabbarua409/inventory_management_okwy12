import 'package:get/get.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class WholesalerSettingController extends GetxController {
  void logout() {
    PrefsHelper.emailId = "";
    PrefsHelper.token = "";
    PrefsHelper.userRole = "";
    PrefsHelper.removeAllPrefData();
    PrefsHelper.isLogIn = false;
    PrefsHelper.setString('isLogIn', false);
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
}
