import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/routes/app_routes.dart';

import '../../../../utils/app_enum.dart';

class WholesalerChangePasswordController extends GetxController {
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

  void resetPassword() {
    // Assuming password change is successful
    Get.toNamed(AppRoutes.bottomNavBar, arguments: {'userRole': userRole});
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
