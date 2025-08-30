import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/models/new_version/update_product_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class WholesalerPendingOrderDetailController extends GetxController {
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;

  // Update orders list type to match the new model
  // RxList<MPendingOrders> orders = <MPendingOrders>[].obs;
  final RxList<Product> products = <Product>[].obs;
  final RxString id = "".obs;
  final companyName = "".obs;

  void fetchData() {
    try {
      final arg = Get.arguments;
      products.value = arg['products'];
      id.value = arg['id'];
      companyName.value = arg['company'];
      appLogger(products);
    } catch (e) {
      appLogger("Failed to get pending data: $e");
    }
  }

  void sendData(BuildContext context) async {
    try {
      List<Map<String, dynamic>> updatedData = [];
      appLogger("Data is now updating");
      for (int index = 0; index < products.length; index++) {
        if (products[index].price! < 0) {
          products[index].price = 0;
        }
        appLogger(
            "id: ${products[index].id}, availability: ${products[index].availability}");

        final updatedItem = UpdateProductModel2(
            product: products[index].id ?? "",
            availability: products[index].availability ?? false,
            price: products[index].price?.toDouble() ?? 0);
        updatedData.add(updatedItem.toJson());
      }

      final url = Urls.updateNewOrderToPending + id.value;
      final response = await ApiService.patchApi(url, {'product': updatedData});
      final isSuccess = response["success"] ?? false;
      appLogger(response);
      if (isSuccess) {
        Get.snackbar("Success", "Products updated successfully");
        Get.back();
        // Get.back();
        showSendOrderSuccessfulDialog(context);
        // Get.back();
      } else {
        appLogger("failed to update product");
        Get.snackbar(
            "Error", response['message'] ?? "Failed to update product");
      }
    } catch (e) {
      appLogger(e);
    }
    // final response = await ApiService.patchApi(url, body)
  }
  // Method to fetch the pending product orders
  // Future<void> fetchPendingProduct() async {
  //   try {
  //     String? token = await PrefsHelper.getToken();
  //     if (token.isEmpty) {
  //       Get.snackbar("Error", "User is not authenticated.");
  //       return;
  //     }

  //     // Call API to fetch pending orders
  //     var response = await ApiService.getApi(Urls.newPendingOrder);

  //     if (response == null) {
  //       Get.snackbar('Error', 'Failed to load orders');
  //       return;
  //     }

  //     // Handle the response when status code is 200 (success)
  //     // var data = response;
  //     // MPendingOrders pendingResponse = MPendingOrders.fromJson(data["data"]);
  //     // appLogger(data["data"][0]);
  //     orders.clear();
  //     if (response == null) {
  //       Get.snackbar('Error', 'Failed to load orders');
  //       return;
  //     }

  //     appLogger("Response: $response");

  //     // Handle the response when status code is 200 (success)
  //     orders.value = <MPendingOrders>[];
  //     if (response["data"] != null && response["data"] is List) {
  //       for (var element in response["data"]) {
  //         orders.add(MPendingOrders.fromJson(element));
  //       }
  //     }
  //     // if (pendingResponse.success == true) {
  //     //   orders.clear();
  //     //   for (var offer in pendingResponse.data) {
  //     //     var products = offer.product
  //     //         .map((product) => Product(
  //     //               productId: ProductId(
  //     //                 id: product.productId.id,
  //     //                 name: product.productId.name,
  //     //                 unit: product.productId.unit,
  //     //                 quantity: product.productId.quantity,
  //     //                 additionalInfo: product.productId.additionalInfo,
  //     //               ),
  //     //               availability: product.availability,
  //     //               price: product.price,
  //     //               id: product.id,
  //     //               total: product.total,
  //     //             ))
  //     //         .toList();
  //     //     orders.add(Datum(
  //     //       id: offer.id,
  //     //       retailer: offer.retailer,
  //     //       product: products,
  //     //       wholeSeller: offer.wholeSeller,
  //     //       status: offer.status,
  //     //       createdAt: offer.createdAt,
  //     //       updatedAt: offer.updatedAt,
  //     //       v: offer.v,
  //     //     ));
  //     //   }
  //     // } else {
  //     //   Get.snackbar('Error', 'Failed to load orders');
  //     // }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while fetching orders');
  //     print("Error fetching orders: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // This method allows you to update specific product data like availability, price, and quantity.
  // void updateProductData(int orderIndex, int productIndex,
  //     {bool? availability, double? price, int? quantity}) {
  //   // Access the product from the orders list
  //   var product = orders[orderIndex].product[productIndex];

  //   // Update availability if provided
  //   if (availability != null) {
  //     product.availability = availability;
  //   }

  //   // Update price if provided and recalculate total
  //   if (price != null) {
  //     product.price = price;
  //     product.calculateTotal(); // Recalculate the total if price changes
  //   }

  //   // Update quantity if provided and recalculate total
  //   if (quantity != null) {
  //     product.productId.quantity = quantity; // Update quantity in ProductId
  //     product.calculateTotal(); // Recalculate the total if quantity changes
  //   }

  //   // Notify listeners for changes
  //   update(); // Make the change observable to the UI
  // }

  // Observable quantity for increment and decrement (used in the UI for product quantities)
  var quantity = 1.obs;

  // Increment the quantity
  void incrementQuantity() {
    quantity.value++;
  }

  // Decrement the quantity (minimum is 1)
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

  void showSendOrderSuccessfulDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
              Get.back();
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: TextWidget(
                text: item.productName ?? "N/A",
                fontSize: 14,
                fontColor: AppColors.black,
                softWrap: true,
                maxLines: null,
                textAlignment: TextAlign.left,
              ),
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: TextWidget(
                text: item.additionalInfo ?? "N/A",
                fontSize: 14,
                fontColor: AppColors.black,
                softWrap: true,
                maxLines: null,
                textAlignment: TextAlign.left,
              ),
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
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Availability:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.availability.toString(),
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Price:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: item.price.toString(),
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 6),
        Row(
          children: [
            const TextWidget(
              text: "Total:",
              fontSize: 14,
              fontColor: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            const SpaceWidget(
              spaceWidth: 10,
            ),
            TextWidget(
              text: ((item.quantity ?? 0) * (item.price ?? 0)).toString(),
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
    // fetchPendingProduct();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
