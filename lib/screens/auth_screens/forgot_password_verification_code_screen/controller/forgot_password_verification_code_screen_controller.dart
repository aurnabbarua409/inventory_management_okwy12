import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class ForgotPasswordVerifyCodeScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var otpTextEditingController1 = TextEditingController();
  var otpTextEditingController2 = TextEditingController();
  var otpTextEditingController3 = TextEditingController();
  var otpTextEditingController4 = TextEditingController();

  var remainingSeconds = 180.obs; // 2.5 minutes
  var canResend = false.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
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
        print(
            "Timer: ${remainingSeconds.value} seconds remaining"); // Debugging
      } else {
        canResend.value = true;
        print("Timer completed. You can resend the code now."); // Debugging
        _timer.cancel();
      }
    });
  }

  void resendCode() {
    remainingSeconds.value = 180;
    canResend.value = false;
    startTimer();
    // Simulate sending the code
    Get.snackbar(
      "Code Sent",
      "A new verification code has been sent to your email.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final remainingSec = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSec.toString().padLeft(2, '0')}';
  }

  void verifyOTP() {
    // Assuming OTP verification is successful
    Get.toNamed(AppRoutes.resetPasswordScreen);
  }
}
