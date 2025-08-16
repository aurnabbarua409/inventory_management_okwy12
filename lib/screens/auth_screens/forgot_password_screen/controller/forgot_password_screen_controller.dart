import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class ForgotPasswordScreenController extends GetxController {
  final emailController = TextEditingController();

  void forgotPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please enter your email address to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else {
      final email = emailController.text;
      try {
        final response =
            await ApiService.postApi(Urls.forgetPassword, {"email": email});
        if (response != null) {
          Get.snackbar("Success", response["message"]);
          Get.toNamed(
            AppRoutes.forgotPasswordVerificationCodeScreen,
            arguments: {'email': emailController.text},
          );
        } else {
          Get.snackbar("Error", response["message"]);
        }
      } catch (e) {
        // Get.snackbar("Error", AppStrings.somethingWentWrong);
        appLogger("Error from forgot password: $e");
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
