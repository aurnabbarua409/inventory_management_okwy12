import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/auth/store_information_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';

class StoreInformationScreenController extends GetxController {
  final businessNameController = TextEditingController();
  final storeAddressController = TextEditingController();
  final locationController = TextEditingController();
  final RxBool isChecked = false.obs;

  var selectedBusinessCategory = 'Education'.obs;

  final List<String> categories = [
    'Education',
    'Communication',
    'Technology',
    'HouseholdItem',
    'OfficeEquipment',
    'BuildingAndConstruction',
    'HealthcareAndFitness',
    'FoodAndProvision',
    'ElectricalAndElectronics',
    'AutomotivesAndBikes',
    'FashionAndBeauty',
    'Other',
  ];

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  void setSelectedBusinessCategory(String? value) {
    selectedBusinessCategory.value = value ?? 'Education';
  }

  Future<void> continueToNextScreen() async {   
    final arguments = Get.arguments;
    final userRole = arguments['userRole'] ?? "";
    final email = arguments['email'] ?? "";
    final userId = arguments['userId'] ?? "";

    if (userId.isEmpty) {
      Get.snackbar('Error', 'User ID is missing.');
      return;
    }
    if (!isChecked.value) {
      Get.snackbar("Oops!",
          "You need to agree to the Terms and Conditions to continue.");
      return;
    }

    Map<String, String> body = {
      "businessName": businessNameController.text.trim(),
      "businessCategory": selectedBusinessCategory.value,
      "location": locationController.text.trim(),
      "role": userRole.toString().capitalizeFirst ?? "",
      "email": email,
    };

    try {
      String storeUrl = "${Urls.storeInfo}$userId";

      var response = await ApiService.patchApi(storeUrl, body);

      if (response != null) {
        // The response is already decoded.
        StoreUpdateResponse storeUpdateResponse =
            StoreUpdateResponse.fromJson(response);

        if (storeUpdateResponse.success) {
          Get.snackbar('Success', storeUpdateResponse.message);

          Get.toNamed(AppRoutes.signupVerificationCodeScreen, arguments: {
            'userRole': userRole,
            'email': email,
            'userId': userId,
          });
        } else {
          Get.snackbar('Error', storeUpdateResponse.message);
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to update store information. Please try again.');
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Store information update failed. Please try again.');
    }
  }

  @override
  void onClose() {
    businessNameController.dispose();
    storeAddressController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
