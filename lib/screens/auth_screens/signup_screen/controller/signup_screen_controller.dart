import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/auth/sign_up_model.dart'; // Make sure to update to the new model file path
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import '../../../../utils/app_enum.dart';

class SignupScreenController extends GetxController {
  // Initially set to null to indicate no role is selected
  var selectedRole = Rxn<UserRole>();

  // TextEditingControllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  UserCreationResponse? signUpData;

  // Function to handle form submission and sign-up API call
  Future<void> handleContinue() async {
    final userRole = selectedRole.value;

    // Ensure a role is selected before continuing
    if (userRole == null) {
      Get.snackbar('Error', 'Please select a role (Retailer/Wholesaler)');
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    Map<String, dynamic> body = {
      "role": userRole.name.capitalizeFirst,
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phoneNumber,
      "verified": false,
      "status": "active",
    };

    try {
      var response = await ApiService.postApi(Urls.signUp, body);

      if (response != null) {
        var data = response; // The response is already decoded.

        signUpData = UserCreationResponse.fromJson(data);

        if (signUpData!.success) {
          String userId = signUpData!.data.id.trim();

          if (userId.isEmpty || userId.length != 24) {
            Get.snackbar('Error', 'Invalid userId received from API.');
            return;
          }
          await PrefsHelper.saveUserEmail(email);
          await PrefsHelper.setString('userId', userId);

          Get.toNamed(AppRoutes.storeInformationScreen, arguments: {
            'userRole': userRole.name,
            'email': email,
            'userId': userId,
          });

          Get.snackbar('Success',
              'User created successfully. Please check your email for verification.');
        } else {
          Get.snackbar('Error', signUpData?.message ?? 'Sign-up failed');
        }
      } else {
        Get.snackbar('Error', 'Invalid response from server');
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-up request failed. Please try again.');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();

    super.onClose();
  }
}
