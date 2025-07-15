import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/retailer/retailer_settings/retailer_profile/retailer_get_profile_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../../../utils/app_enum.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';

class WholesalerProfileScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole.retailer.obs;
  final imageFile = Rx<File?>(null);
  var image = Rx<String>('');
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

  void fetchProfile() async {
    final response = await ApiService.getApi(Urls.userProfile,
        header: {"Authorization": PrefsHelper.token});
    if (kDebugMode) {
      print(
          "=================================> running fetching profile for profile");
      print("======================================> $response");
    }
    if (response != null) {
      fullNameController.text = response["data"]["name"];
      businessNameController.text =
          response["data"]["storeInformation"]["businessName"];
      emailController.text = response["data"]["email"];
      addressController.text = response["data"]["storeInformation"]["location"];
      image.value = response["data"]["image"];
    } else {
      Get.snackbar("Error", response["message"]);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchProfile();
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
