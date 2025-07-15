import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/models/auth/otp_verification_model.dart';
import '../../../../utils/app_enum.dart';

class SignupVerifyCodeScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var otpTextEditingController1 = TextEditingController();
  var otpTextEditingController2 = TextEditingController();
  var otpTextEditingController3 = TextEditingController();
  var otpTextEditingController4 = TextEditingController();

  var remainingSeconds = 180.obs; // 5 minutes countdown
  var canResend = false.obs;
  late UserRole userRole;
  late String userId;
  late String email;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;

    // Extract userRole, email, and userId from arguments
    String roleString = arguments['userRole'] ?? "";
    email = arguments['email'] ?? "";
    userId = arguments['userId'] ?? "";

    if (userId.isEmpty) {
      Get.snackbar("Error", "User ID is missing.");
      return;
    }

    // Convert string role to Enum and ensure only valid roles are allowed
    userRole = UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == roleString.toLowerCase(),
      orElse: () {
        Get.snackbar("Error", "Invalid user role.");
        return UserRole.retailer; // Default to Retailer
      },
    );

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
      } else {
        canResend.value = true;
        _timer.cancel();
      }
    });
  }

  void resendCode() {
    
    remainingSeconds.value = 180;
    canResend.value = false;
    startTimer();
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

  Future<void> verifyOTP() async {
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
      "otp": otp,
      "email": email,
    };

    try {
      var response = await ApiService.postApi(Urls.verifyingOTP, body);

      if (response != null) {
        OTPVerificationModel otpVerificationModel =
            OTPVerificationModel.fromJson(response);

        if (otpVerificationModel.success) {
          Get.snackbar("Success", "OTP verified successfully");

          Get.offAllNamed(AppRoutes.onboardingScreen);
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
