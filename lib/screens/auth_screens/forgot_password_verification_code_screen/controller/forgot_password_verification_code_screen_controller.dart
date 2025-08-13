import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/auth/otp_verification_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../../routes/app_routes.dart';

class ForgotPasswordVerifyCodeScreenController extends GetxController {
  var otpTextEditingController1 = TextEditingController();
  var otpTextEditingController2 = TextEditingController();
  var otpTextEditingController3 = TextEditingController();
  var otpTextEditingController4 = TextEditingController();

  var remainingSeconds = 180.obs; // 2.5 minutes
  var canResend = false.obs;

  late Timer _timer;
  late String email;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    final arguments = Get.arguments;
    email = arguments['email'] ?? "";
  }

  @override
  void onClose() {
    _timer.cancel();
    otpTextEditingController1.dispose();
    otpTextEditingController2.dispose();
    otpTextEditingController3.dispose();
    otpTextEditingController4.dispose();
    super.onClose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        _timer.cancel();
      }
    });
  }

  void resendCode() async {
    remainingSeconds.value = 180;
    canResend.value = false;
    startTimer();
    // Simulate sending the code
    try {
      final response =
          await ApiService.postApi(Urls.forgetPassword, {"email": email});
      if (response != null) {
        Get.snackbar(
          "Code Sent",
          "A new verification code has been sent to your email.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar("Error", response["message"]);
      }
    } catch (e) {
      Get.snackbar("Error", AppStrings.somethingWentWrong);
    }
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final remainingSec = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSec.toString().padLeft(2, '0')}';
  }

  void verifyOTP() async {
    // Assuming OTP verification is successful
    final otp =
        "${otpTextEditingController1.text}${otpTextEditingController2.text}${otpTextEditingController3.text}${otpTextEditingController4.text}";

    if (otp.length != 4) {
      Get.snackbar("Error", "Please enter a valid 4-digit OTP");
      return;
    }

    if (email.isEmpty) {
      Get.snackbar("Error", "Email is missing. Please try again.");
      return;
    }

    Map<String, dynamic> body = {
      "email": email,
      "otp": num.parse(otp),
    };

    try {
      var response = await ApiService.postApi(Urls.verifyingOTP, body);

      if (response != null) {
        OTPVerificationModel otpVerificationModel =
            OTPVerificationModel.fromJson(response);

        if (otpVerificationModel.success) {
          PrefsHelper.setString("token", otpVerificationModel.data.data);

          appLogger(otpVerificationModel.data.data);
          appLogger(PrefsHelper.token);
          Get.snackbar("Success", "OTP verified successfully");
          Get.toNamed(AppRoutes.resetPasswordScreen);
        } else {
          Get.snackbar("Error", otpVerificationModel.message);
        }
      } else {
        Get.snackbar("Error", "OTP verification failed. Please try again.");
      }
    } catch (e) {
      Get.snackbar(
          "Error", "OTP verification request failed. Please try again.");
    }
  }
}
