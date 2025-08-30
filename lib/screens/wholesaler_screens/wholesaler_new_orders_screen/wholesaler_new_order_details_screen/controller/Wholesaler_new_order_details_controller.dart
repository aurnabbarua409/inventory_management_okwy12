import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
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
import 'package:path_provider/path_provider.dart';

import '../../../../../constants/app_colors.dart';

class WholesalerNewOrderDetailsController extends GetxController {
  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final priceController = TextEditingController();

  final RxList data = [].obs;
  // Observable quantity for increment and decrement
  var quantity = 1.obs;
  final RxList<Product> products = <Product>[].obs;
  //final RxList<Map<bool, int>> availableList = <Map<bool, int>>[].obs;
  final orderId = "".obs;
  final companyName = "".obs;
  void fetchData() async {
    try {
      final args = Get.arguments;
      orderId.value = args['id'];
      companyName.value = args['company'];

      final fileName = '${orderId.value}.txt';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      if (await file.exists()) {
        final fileContent = await file.readAsString();
        if (fileContent.trim().isNotEmpty) {
          // Parse the file content to products list
          // Assuming each product is separated by "---" and fields by new lines
          final productBlocks = fileContent.split('---');
          final List<Product> loadedProducts = [];
          for (var block in productBlocks) {
            if (block.trim().isEmpty) continue;
            final lines = block.trim().split('\n');
            String? id, productName, unit, additionalInfo;
            int? quantity;
            double? price;
            bool? availability;
            for (var line in lines) {
              if (line.startsWith('Product ID:')) {
                id = line.replaceFirst('Product ID:', '').trim();
              } else if (line.startsWith('Product Name:')) {
                productName = line.replaceFirst('Product Name:', '').trim();
              } else if (line.startsWith('Unit:')) {
                unit = line.replaceFirst('Unit:', '').trim();
              } else if (line.startsWith('Quantity:')) {
                quantity =
                    int.tryParse(line.replaceFirst('Quantity:', '').trim());
              } else if (line.startsWith('Additional Info:')) {
                additionalInfo =
                    line.replaceFirst('Additional Info:', '').trim();
              } else if (line.startsWith('Price:')) {
                price = double.tryParse(line.replaceFirst('Price:', '').trim());
              } else if (line.startsWith('Availability:')) {
                final availStr = line.replaceFirst('Availability:', '').trim();
                availability = availStr.toLowerCase() == 'true';
              }
            }
            loadedProducts.add(Product(
              id: id ?? '',
              productName: productName,
              unit: unit,
              quantity: quantity,
              additionalInfo: additionalInfo,
              price: price,
              availability: availability,
              retailer: '',
              status: null,
              createAt: '',
              updatedAt: '',
              v: null,
            ));
          }
          products.value = loadedProducts;
          appLogger("Loaded products from $fileName");
        } else {
          products.value = args['products'];
          appLogger("Loaded products from arguments");
        }
      } else {
        products.value = args['products'];
        appLogger("Loaded products from arguments");
      }
      appLogger(
          "order id while fetching data from new order: ${orderId.value}");
    } catch (e) {
      appLogger("failed to get new order details data: $e");
    }
  }

  void sendData(BuildContext context) async {
    try {
      List<Map<String, dynamic>> updatedData = [];
      appLogger("Data is now updating");
      for (int index = 0; index < products.length; index++) {
        var price = products[index].price ?? 0;
        if (price < 0) {
          price = 0;
        }
        // appLogger(
        //     "id: ${products[index].id}, availability: ${availableList[index].keys.first}");
        final updatedItem = UpdateProductModel2(
            product: products[index].id ?? "",
            availability: products[index].availability ?? false,
            price: price);
        updatedData.add(updatedItem.toJson());
      }

      appLogger("data sending with update body: $updatedData");
      final url = Urls.updateNewOrderToPending + orderId.value;
      final response = await ApiService.patchApi(url, {'product': updatedData});
      final isSuccess = response["success"] ?? false;
      appLogger("response after product updated: $response");
      if (isSuccess) {
        final fileName = '${orderId.value}.txt';
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$fileName');

        if (await file.exists()) {
          await file.delete();
          appLogger("Draft file $fileName deleted after sending order.");
        }
        Get.back();
        Get.snackbar("Success", "Products updated successfully");
        showSendOrderSuccessfulDialog(context);
      } else {
        appLogger("failed to update product");
        Get.snackbar("Error", response['message'] ?? "Failed to update");
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
        Center(
          child: TextWidget(
            text:
                "You want to send this order to ${companyName.value} for review?",
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
                    sendData(context);
                    Get.back();
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
        Center(
          child: TextWidget(
            text: "Order successfully sent to ${companyName.value} for review",
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
    selectedUnit.value = value ?? 'pcs';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
    // availableList.value = List.generate(
    //   products.length,
    //   (index) => {false: 0},
    // );
  }

  void onSave() async {
    try {
      final fileName = '${orderId.value}.txt';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      final buffer = StringBuffer();
      for (var product in products) {
        buffer.writeln('Product ID: ${product.id ?? "N/A"}');
        buffer.writeln('Product Name: ${product.productName ?? "N/A"}');
        buffer.writeln('Unit: ${product.unit ?? "N/A"}');
        buffer.writeln('Quantity: ${product.quantity ?? "N/A"}');
        buffer.writeln('Additional Info: ${product.additionalInfo ?? "N/A"}');
        buffer.writeln('Price: ${product.price ?? "N/A"}');
        buffer.writeln('Availability: ${product.availability ?? "N/A"}');
        buffer.writeln('---');
      }
      await file.writeAsString(buffer.toString());
      Get.snackbar('Success', 'Order saved as draft');
    } catch (e) {
      appLogger('Failed to save order: $e');
      Get.snackbar('Error', 'Failed to save order');
    }
  }

  void showProductDetailsDialog(BuildContext context, Product item) {
    showCustomPopup(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SpaceWidget(spaceWidth: 16),
            const Center(
              child: TextWidget(
                text: AppStrings.productDetails,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.black,
              ),
            ),
            IconButtonWidget(
              onTap: () {
                Get.back();
              },
              icon: AppIconsPath.closeIcon,
              size: 20,
              color: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 4),
        const Divider(
          color: AppColors.greyLight,
          height: 1,
        ),
        const SpaceWidget(spaceHeight: 16),
        Row(
          children: [
            const TextWidget(
              text: "Product Name:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.productName ?? "N/A",
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Additional Info:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.additionalInfo ?? "N/A",
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Quantity:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.quantity.toString(),
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Unit:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.unit ?? "N/A",
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
