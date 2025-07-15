import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_app/routes/app_routes.dart';

import '../../../../../utils/app_enum.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';

class WholesalerProfileScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole.retailer.obs;
  final imageFile = Rx<File?>(null);

  // Controllers for form fields
  final fullNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  /// Show image source selection dialog
  void showImageSourceDialog(BuildContext context) {
    showCustomPopup(context, [
      Text('Select Image Source'),
      ListTile(
        leading: const Icon(Icons.photo_library),
        title: const Text('Gallery'),
        onTap: () {
          Get.back();
          pickImage(ImageSource.gallery);
        },
      ),
      ListTile(
        leading: const Icon(Icons.camera_alt),
        title: const Text('Camera'),
        onTap: () {
          Get.back();
          pickImage(ImageSource.camera);
        },
      ),
    ]);
  }

  /// Pick an Image from the gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80, // Compress image quality to 80%
        maxWidth: 800, // Limit max width
        maxHeight: 800, // Limit max height
      );

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        Get.snackbar(
          "Success",
          "Image selected successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "No Image",
          "No image selected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Handle Continue Button Press
  void handleContinue() {
    if (formKey.currentState?.validate() ?? false) {
      final userRole = selectedRole.value;
      navigateToRoleSpecificScreen(userRole);
    } else {
      Get.snackbar(
        "Error",
        "Please fill all fields correctly",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Navigate based on user role
  void navigateToRoleSpecificScreen(UserRole userRole) {
    String route = AppRoutes.retailerHomeScreen;
    if (userRole == UserRole.wholesaler) {
      route = AppRoutes.retailerHomeScreen;
    }
    Get.toNamed(route, arguments: {'userRole': userRole});
    print("$userRole selected. Navigating to $route.");
  }

  @override
  void onClose() {
    // Dispose of all controllers to avoid memory leaks
    fullNameController.dispose();
    businessNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
