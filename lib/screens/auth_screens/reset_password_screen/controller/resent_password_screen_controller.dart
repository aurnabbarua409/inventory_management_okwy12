import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/routes/app_routes.dart';

import '../../../../constants/app_colors.dart';

class ResetPasswordScreenController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void resetPassword() {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in both password fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else {
      Get.offAllNamed(AppRoutes.signinScreen);
      print(
          'Email: ${newPasswordController.text}, Password: ${confirmPasswordController.text}');
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
