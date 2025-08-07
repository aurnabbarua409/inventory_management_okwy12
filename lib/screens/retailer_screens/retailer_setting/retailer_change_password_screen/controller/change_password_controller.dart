import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/auth/change_password_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../../../../utils/app_enum.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole.retailer.obs;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  get userRole => null;

  void handleContinue() {
    if (formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with signup
      final userRole = selectedRole.value;

      if (selectedRole.value == UserRole.retailer) {
        Get.toNamed(AppRoutes.storeInformationScreen,
            arguments: {'userRole': userRole});
        print("Retailer selected. Navigate to Retailer screen.");
      } else if (selectedRole.value == UserRole.wholesaler) {
        Get.toNamed(AppRoutes.storeInformationScreen,
            arguments: {'userRole': userRole});
        print("Wholesaler selected. Navigate to Wholesaler screen.");
      }
    }
  }

  void resetPassword() async {
    // Assuming password change is successful
    if (formKey.currentState!.validate()) {
      final currentPass = currentPasswordController.text;
      final newPass = newPasswordController.text;
      final confirmPass = confirmNewPasswordController.text;

      final changePassword = ChangePasswordModel(
          currentPassword: currentPass,
          newPassword: newPass,
          confirmPassword: confirmPass);
      if (kDebugMode) {
        print("$currentPass/$newPass/$confirmPass");
        print(changePassword.toJson());
      }
      final response = await ApiService.postApi(
        Urls.changePassword,
        changePassword.toJson(),
      );
      if (response != null) {
        if (kDebugMode) {
          print("response from reset password: $response");
        }
        Get.snackbar("Success", response["message"]);
        Get.toNamed(AppRoutes.bottomNavBar, arguments: {'userRole': userRole});
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmNewPasswordController.clear();
      }
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
