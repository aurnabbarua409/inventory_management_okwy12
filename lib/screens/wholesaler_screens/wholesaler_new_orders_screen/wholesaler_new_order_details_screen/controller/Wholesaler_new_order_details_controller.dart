import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/models/new_version/update_product_model.dart';

import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../../../../constants/app_colors.dart';

class WholesalerNewOrderDetailsController extends GetxController {
  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();

  final RxList data = [].obs;
  // Observable quantity for increment and decrement
  var quantity = 1.obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<Map<bool, double>> availableList = <Map<bool, double>>[].obs;
  final orderId = "".obs;
  void fetchData() {
    try {
      final args = Get.arguments;
      products.value = args['products'];
      orderId.value = args['id'];
      appLogger(
          "order id while fetching data from new order: ${orderId.value}");
    } catch (e) {
      appLogger("failed to get new order details data: $e");
    }
  }

  void sendData() async {
    try {
      List<Map<String, dynamic>> updatedData = [];
      appLogger("Data is now updating");
      for (int index = 0; index < products.length; index++) {
        appLogger(
            "id: ${products[index].id}, availability: ${availableList[index].keys.first}");
        final updatedItem = UpdateProductModel(
            product: products[index].id ?? "",
            availability: availableList[index].keys.first,
            price: availableList[index].values.first);
        updatedData.add(updatedItem.toJson());
      }

      final url = Urls.updateProduct + orderId.value;
      final response = await ApiService.patchApi(url, updatedData);
      final isSuccess = response["success"] ?? false;
      appLogger(response);
      if (isSuccess) {
        Get.snackbar("Success", "Products updated successfully");
      } else {
        appLogger("failed to update product");
        Get.snackbar("Error", "Failed to update product");
      }
    } catch (e) {
      appLogger("Error in update new order: $e");
    }
  }

  void showSendOrderDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: TextWidget(
            text: AppStrings.areYouSure,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.wholesalerAreYouSureDesc,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButtonWidget(
                  onPressed: () {
                    Get.back();
                  },
                  label: AppStrings.no,
                  backgroundColor: AppColors.white,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  textColor: AppColors.primaryBlue,
                  borderColor: AppColors.primaryBlue,
                  fontSize: 14,
                ),
              ),
              const SpaceWidget(spaceWidth: 16),
              Expanded(
                flex: 1,
                child: ButtonWidget(
                  onPressed: () {
                    sendData();
                    Get.back();
                    showSendOrderSuccessfulDialog(context);
                  },
                  label: AppStrings.yes,
                  backgroundColor: AppColors.primaryBlue,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  void showSendOrderSuccessfulDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: ImageWidget(
            height: 64,
            width: 64,
            imagePath: AppImagesPath.checkImage,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        const Center(
          child: TextWidget(
            text: AppStrings.wholesalerOrderSentSuccessfully,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.wholesalerOrderSentSuccessfullyDesc,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

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
      appLogger(
          'Product: ${productNameController.text}, Unit: ${unitController.text}, Quantity: ${quantity.value}, Additional Info: ${additionalInfoController.text}');

      // Navigate to another screen
      Get.offAllNamed(AppRoutes.retailerFindWholeSellerScreen);
    }
  }

  // void fetchOrderDatails(String id) async {
  //   try {
  //     final url = "${Urls.wholesalerProductDetailsFromRetailer}$id";
  //     final response = await ApiService.getApi(url);
  //     appLogger(response);
  //     final data = Order.fromJson(response["data"]);
  //     appLogger(data.product);
  //   } catch (e) {
  //     appLogger(e);
  //   }
  // }

  void setSelectedUnit(String? value) {
    selectedUnit.value = value ?? 'Kg';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
    availableList.value = List.generate(
      products.length,
      (index) => {false: 1.0},
    );
  }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }
}
