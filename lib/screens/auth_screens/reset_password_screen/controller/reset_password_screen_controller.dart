import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../../constants/app_colors.dart';

class ResetPasswordScreenController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void resetPassword() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Please fill in both password fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else if (newPasswordController.text != confirmPasswordController.text) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else {
      // need to implement
      try {
        final token = await PrefsHelper.getToken();
        appLogger("new token"); // Retrieve token asynchronously
        appLogger(token);
        Map<String, String> mainHeader = {
          'Authorization': token,
          'Content-Type': 'application/json',
        };
        final response = await ApiService.postApi(
            Urls.resetPassword,
            {
              "newPassword": newPasswordController.text,
              "confirmPassword": confirmPasswordController.text
            },
            header: mainHeader);
        if (response["success"]) {
          Get.closeAllSnackbars();
          Get.snackbar("Success", response["message"]);
          Get.toNamed(AppRoutes.signinScreen);
        } else {
          Get.closeAllSnackbars();
          Get.snackbar("Error", response["message"]);
        }
        appLogger(response);
      } catch (e) {
        appLogger(e);
      }
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
