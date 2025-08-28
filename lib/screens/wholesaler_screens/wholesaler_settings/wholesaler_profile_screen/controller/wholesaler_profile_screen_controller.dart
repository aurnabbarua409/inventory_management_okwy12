import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../../../../utils/app_enum.dart';
import '../../../../../widgets/popup_widget/popup_widget.dart';

class WholesalerProfileScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedRole = UserRole.retailer.obs;
  final imageFile = Rx<File?>(null);
  var image = Rx<String>('');

  // Controllers for form fields
  var fullNameController = TextEditingController();
  var businessNameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  final RxString phoneNumber = "".obs;
  final RxBool isValidPhonenumber = true.obs;
  var phone = PhoneNumber().obs;
  final RxString userName = ''.obs;

  Future<void> updateProfileRepo() async {
    if (!isValidPhonenumber.value) {
      Get.snackbar("Invalid Phone Number", "Please write a valid phonenumber");
      return;
    }

    // if (!formKey.currentState!.validate()) {
    //   return;
    // }
    // updateIsLoading.value = true;
    // update();

    // Prepare the body for the PATCH request
    Map<String, dynamic> body = {
      "name": fullNameController.text,
      "email": emailController.text,
      "storeInformation": {
        "businessName": businessNameController.text,
        "location": addressController.text
      },
      if (phoneNumber.value.isNotEmpty) "phone": phoneNumber.value,
      // "storeInformation": {
      //   "businessName": businessNameController.text,
      //   "location": addressController.text
      // },

      // You can update this to dynamically pass image URL
    };
    appLogger("${phoneNumber.value} : ${phoneController.text}");

    try {
      // Call the patchApi function with the body data
      // var response = await ApiService.patchApi(Urls.userProfile, body);
      final response = await ApiService.patchApi(Urls.userProfile, body);
      await ApiService.MultipartRequest1(
          url: Urls.userProfile, imagePath: imageFile.value?.path);
      if (response != null) {
        Get.snackbar("Success: ${response['success']}", response['message']);
      }
      fetchProfile();
      Get.back();

      // if (response != null) {
      // Check the response and handle accordingly
      // if (response.statusCode == 200) {
      //   Get.snackbar(
      //     "Success",
      //     "Profile updated successfully!",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //   );

      //   // Optionally, refresh the profile data after a successful update
      // } else {
      //   Get.snackbar(
      //     "Error",
      //     "Failed to update profile. Please try again.",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
    }
    // }
    // } else {
    //   Get.snackbar(
    //     "Error",
    //     "Failed to update profile. Please check your connection.",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // }

    catch (e) {
      appLogger(e);
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    // updateIsLoading.value = false;
    // update();
  }

  /// Show image source selection dialog
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
    if (!isValidPhonenumber.value) {
      return;
    }
    if (formKey.currentState?.validate() ?? false) {
      final userRole = selectedRole.value;
      updateProfileRepo();
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
    return;
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

  Future<void> fetchProfile() async {
    try {
      final response = await ApiService.getApi(Urls.userProfile,
          header: {"Authorization": "Bearer ${PrefsHelper.token}"});
      if (kDebugMode) {
        print(
            "=================================> running fetching profile for profile");
        print("======================================> $response");
      }

      if (response != null) {
        // final data = ProfileModel.fromJson(response);
        // appLogger(data.data.email);
        // final data = WholeSalerDetails.fromJson(response["data"]);
        userName.value = response["data"]["name"] ?? "";
        fullNameController.text = response["data"]["name"] ?? "";
        businessNameController.text =
            response["data"]["storeInformation"]["businessName"] ?? "";
        emailController.text = response["data"]["email"] ?? "";
        addressController.text =
            response["data"]["storeInformation"]["location"] ?? "";
        phone.value = await PhoneNumber.getRegionInfoFromPhoneNumber(
            response["data"]["phone"] ?? "");

        // phoneController.text = phoneNumber.parseNumber();
        appLogger(phoneNumber);
        // countryCode.value = phoneNumber.isoCode ?? "+234";
        image.value = response["data"]["image"] ?? "";
        PrefsHelper.totalOrders = response['data']['order'];
        PrefsHelper.isSubscribed = response['data']['isSubscribed'];
        appLogger(
            "total orders: ${PrefsHelper.totalOrders} and isSubscribed: ${PrefsHelper.isSubscribed}");
        appLogger(userName.value);
      } else {
        appLogger("response is null");
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      appLogger("Error from wholesaler profile controller: $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfile();
  }

  void initial() {
    fullNameController = TextEditingController();
    businessNameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    fetchProfile();
  }

  @override
  void onClose() {
    // Dispose of all controllers to avoid memory leaks
    fullNameController.dispose();
    businessNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
