import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/routes/app_routes.dart';

import '../../../../../constants/app_colors.dart';

class WholesalerNewOrderDetailsController extends GetxController {
  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();

  // Observable quantity for increment and decrement
  var quantity = 1.obs;

  /// Increment the quantity
  void incrementQuantity() {
    quantity.value++;
  }

  var selectedUnit = 'Kg'.obs;

  final List<String> units = [
    'Kg',
    'Pcs',
    'Roll',
    'Crate',
    'Bottle',
    'Carton',
    'Gal',
    'Bag',
    'Pkt',
    'Other',
  ];

  /// Decrement the quantity (minimum is 1)
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    } else {
      Get.snackbar(
        'Warning',
        'Quantity cannot be less than 1',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.yellow,
        colorText: AppColors.blackDarkest,
      );
    }
  }

  /// Validate input and handle product creation
  void createProduct() {
    if (productNameController.text.isEmpty ||
        unitController.text.isEmpty ||
        additionalInfoController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } else {
      Get.snackbar(
        'Success',
        'Product added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.brightGreen,
        colorText: AppColors.white,
      );

      // Debugging: Print details to console
      print(
          'Product: ${productNameController.text}, Unit: ${unitController.text}, Quantity: ${quantity.value}, Additional Info: ${additionalInfoController.text}');

      // Navigate to another screen
      Get.offAllNamed(AppRoutes.retailerFindWholeSellerScreen);
    }
  }

  void setSelectedUnit(String? value) {
    selectedUnit.value = value ?? 'Kg';
  }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }
}
