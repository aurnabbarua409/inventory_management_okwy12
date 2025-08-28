import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:inventory_app/models/auth/sign_up_model.dart'; // Make sure to update to the new model file path
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
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
  // final phoneNumberController = TextEditingController();
  PhoneNumber phone = PhoneNumber(isoCode: "NG");
  final RxString phoneNumber = "".obs;
  final RxBool isValidPhonenumber = true.obs;
  final countryCode = "NG".obs;
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

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }
    if (!isValidPhonenumber.value) {
      return;
    }

    Map<String, dynamic> body = {
      "role": userRole.name.capitalizeFirst,
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phoneNumber.value,
      "verified": false,
      "status": "active",
    };

    try {
      var response = await ApiService.postApi(Urls.signUp, body);
      appLogger("response in signup first page: $response");
      if (response != null) {
        var data = response; // The response is already decoded.

        signUpData = UserCreationResponse.fromJson(data);

        if (signUpData!.success) {
          String userId = signUpData!.data.id.trim();

          // if (userId.isEmpty || userId.length != 24) {
          //   Get.snackbar('Error', 'Invalid userId received from API.');
          //   return;
          // }
          await PrefsHelper.saveUserEmail(email);
          await PrefsHelper.setString('userId', userId);

          Get.toNamed(AppRoutes.storeInformationScreen, arguments: {
            'userRole': userRole.name,
            'email': email,
            'userId': userId,
          });

          Get.snackbar('Success',
              signUpData?.message ?? "Please fully fill up your information");
        } else {
          Get.snackbar('Error', signUpData?.message ?? 'Sign-up failed');
        }
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
    super.onClose();
  }
}
