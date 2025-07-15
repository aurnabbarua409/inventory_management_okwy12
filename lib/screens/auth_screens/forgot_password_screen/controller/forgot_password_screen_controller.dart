import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ForgotPasswordScreenController extends GetxController {
  final emailController = TextEditingController();

  void forgotPassword() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill email field ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else {
      Get.toNamed(
        AppRoutes.forgotPasswordVerificationCodeScreen,
        arguments: {'email': emailController.text},
      );
      print('Email: ${emailController.text}');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
