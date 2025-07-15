import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/auth/sign_in_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_enum.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class SignInScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole;
  bool isLoading = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  MSignIn? signInData;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController(
        text: kDebugMode
            ? 'rahipeg395@hosintoy.com'
            : ''); //hilaryonyenkem@yahoo.com hoyevi9323@calmpros.com  bewir47352@erapk.com
    passwordController = TextEditingController(
        text: kDebugMode ? '12345678' : ''); //Ctg..123 Nnadim123@
  }

  Future<void> signInUser() async {
    try {
      if (formKey.currentState == null || !(formKey.currentState!.validate())) {
        return;
      }

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Please enter both email and password.');
        return;
      }

      isLoading = true;
      update();
      final response = await _performSignInRequest(email, password);
      appLogger(response);

      // Null check for response before proceeding
      if (response == null) {
        Get.snackbar('Error', 'Login request failed. Please try again.');
        return;
      }

      if (response['success'] != null && response['success']) {
        await _saveUserDataAndNavigate(response);
      } else {
        Get.snackbar(
            'Error', response['message'] ?? 'Login failed. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login request failed. Please try again.');
      debugPrint("SignIn Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<dynamic> _performSignInRequest(String email, String password) async {
    final Map<String, String> body = {
      "email": email,
      "password": password,
    };

    final Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    return await ApiService.postApi(Urls.signIn, body, header: header)
        .timeout(const Duration(seconds: 30));
  }

  Future<void> _saveUserDataAndNavigate(dynamic signInData) async {
    final token = signInData["data"]?["token"] ?? "";
    final role = signInData["data"]?["role"] ?? "";
    final userId = signInData["data"]?["userId"] ?? "";
    final email = signInData["data"]?["email"] ?? "";

    if (token.isEmpty || role.isEmpty || userId.isEmpty) {
      Get.snackbar('Error', 'Missing user data. Please try again.');
      return;
    }

    // Save the user data to PrefsHelper
    PrefsHelper.token = token;
    PrefsHelper.isLogIn = true;
    PrefsHelper.setString('token', token);
    PrefsHelper.setString('userRole', role);
    PrefsHelper.setString('userId', userId);
    PrefsHelper.setString('email', email);
    PrefsHelper.setBool("isLogIn", true);
    await PrefsHelper.getAllPrefData();

    debugPrint("User Role: ======================> $role");
    debugPrint("User ID: ======================> $userId");
    debugPrint("User Email: ======================> $email");

    if (role == 'Retailer') {
      Get.offAllNamed(AppRoutes.retailerHomeScreen,
          arguments: {'userId': userId});
    } else if (role == 'Wholesaler') {
      Get.offAllNamed(AppRoutes.wholesalerHomeScreen,
          arguments: {'userId': userId});
    } else {
      throw Exception('Unknown role detected.');
    }

    Get.offAllNamed(AppRoutes.bottomNavBar,
        arguments: {'userRole': role, 'userId': userId});

    // Clear input fields
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    debugPrint("SignInScreenController is being disposed");
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
