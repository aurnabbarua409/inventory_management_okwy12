import 'dart:convert';
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
import '../../../../../../utils/app_enum.dart';
import '../../../../../widgets/popup_widget/popup_widget.dart';

class ProfileScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole.retailer.obs;
  final imageFile = Rx<File?>(null);
  var isLoading = false.obs;
  var updateIsLoading = false.obs;
  var image = Rx<String>(''); // Observable for image URL
  final RxString userName = ''.obs;

  ProfileResponse getuserModel = ProfileResponse.fromJson({});
  ProfileData get getProfileData => getuserModel.data;

  // Controllers for form fields
  final businessNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  final RxString phoneNumber = "".obs;
  final RxBool isValidPhonenumber = true.obs;

  /// Get User Profile
  void getProfileRepo() async {
    isLoading.value = true;
    // update();

    try {
      String? userId = PrefsHelper.userId;

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      String profileUrl = Urls.userProfile;
      var response = await ApiService.getApi(profileUrl,
          header: {"Authorization": "Bearer ${PrefsHelper.token}"});

      if (response == null) {
        Get.snackbar("Error", "Failed to load profile");
        return;
      }
      if (kDebugMode) {
        print(
            "====================================     response       ======================");
        print(response["data"]["storeInformation"]["businessName"]);
        print(response["data"]["image"]);
        print(response);
        print(PrefsHelper.token);
      }
      // getuserModel = ProfileResponse.fromJson(response);

      // Debugging: Print the profile data
      // debugPrint(
      //     "--------------------------------Fetched Profile: ${getuserModel.data}");
      // if (kDebugMode) {
      //   print(
      //       "====================================================================>");
      //   print(getuserModel.data.businessName);
      //   print(
      //       "====================================================================>");
      // }
      // Populate Controllers with Data
      userName.value = response["data"]["name"] ?? "";
      fullNameController.text = response["data"]["name"] ?? "";
      businessNameController.text =
          response["data"]["storeInformation"]["businessName"] ?? "";
      emailController.text = response["data"]["email"] ?? "";
      addressController.text =
          response["data"]["storeInformation"]["location"] ?? "";
      phoneController.text = response["data"]["phone"] ?? "";
      image.value = response["data"]["image"] ?? "";

      appLogger(image.value);
    } catch (e) {
      // Get.snackbar("Error", "An error occurred: $e");
      if (kDebugMode) {
        print(e.toString());
      }
    }

    isLoading.value = false;
    // update();
  }

  /// Update User Profile
  Future<void> updateProfileRepo() async {
    // if (!formKey.currentState!.validate()) {
    //   return;
    // }

    try {
      if (!isValidPhonenumber.value) {
        return;
      }
      updateIsLoading.value = true;
      // update();

      // Prepare the body for the PATCH request
      Map<String, dynamic> body = {
        "name": fullNameController.text,
        "email": emailController.text,
        "storeInformation": {
          "businessName": businessNameController.text,
          "location": addressController.text
        },
        // "businessName": businessNameController.text,
        // "storeInformation": {"location": addressController.text},
        // You can update this to dynamically pass image URL
        if (phoneNumber.value.isNotEmpty) "phone": phoneNumber.value,
      };

      // try {
      // Call the patchApi function with the body data
      // var response = await ApiService.patchApi(Urls.userProfile, body);
      await ApiService.patchApi(Urls.userProfile, body);
      await ApiService.MultipartRequest1(
          url: Urls.userProfile, imagePath: imageFile.value?.path);

      getProfileRepo();
      Get.back();
      // final imageRespinse = await ApiService.updateProfileImage(
      //     imageFile.value, Urls.userProfile);
      // appLogger(response.body);
      // appLogger(response.statusCode);
      // if (response.statusCode == 200) {
      //   Get.snackbar(
      //     "Success",
      //     "Profile updated successfully!",
      //   );
      // } else {
      //   Get.snackbar(
      //     "Error",
      //     "Failed to update profile. Please try again.",
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // }
      // if (response != null) {
      // Check the response and handle accordingly
      //   if (response["success"]) {
      //     Get.snackbar(
      //       "Success",
      //       "Profile updated successfully!",
      //       snackPosition: SnackPosition.BOTTOM,
      //     );

      //     // Optionally, refresh the profile data after a successful update
      //     getProfileRepo();
      //     Get.back();
      //   } else {
      //     Get.snackbar(
      //       "Error",
      //       "Failed to update profile. Please try again.",
      //       snackPosition: SnackPosition.BOTTOM,
      //     );
      //   }
      // } else {
      //   Get.snackbar(
      //     "Error",
      //     "Failed to update profile. Please check your connection.",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      // }
      // } catch (e) {
      //   appLogger(e);
      //   Get.snackbar(
      //     "Error",
      //     "An error occurred: $e",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      // }

      //   updateIsLoading.value = false;
      // }
    } catch (e) {
      appLogger(e);
      Get.snackbar(
        "error",
        e.toString(),
      );
    }
    // update();
  }

  /// Show Image Source Selection
  void showImageSourceDialog(BuildContext context) {
    showCustomPopup(context, [
      const Text('Select Image Source'),
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

  /// Pick Image from Gallery or Camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        appLogger(imageFile.value);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
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
    debugPrint("$userRole selected. Navigating to $route.");
  }

  @override
  void onInit() {
    getProfileRepo();
    super.onInit();
  }
}
