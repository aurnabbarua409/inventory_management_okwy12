import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart'
    as getPending;
import 'package:inventory_app/models/new_version/update_product_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RetailerPendingOrderDetailsHistoryController extends GetxController {
  var token = ''.obs;
  var selectAll = false.obs;
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;
  var isListening = false.obs;
  var lastWords = ''.obs;
  // Update orders list type to match the new model
  RxList<MPendingOrders> orders = <MPendingOrders>[].obs;

  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final RxInt quantity = 0.obs;
  final RxList<Product> productList = <Product>[].obs;
  final RxList<getPending.Product> products = <getPending.Product>[].obs;
  @override
  void onInit() {
    super.onInit();
    // fetchPending();
    fetchData();
  }

  void fetchData() {
    final arg = Get.arguments;
    products.value = arg['products'];
    if (products.isNotEmpty) {
      products.sort(
        (a, b) => a.createAt!.compareTo(b.createAt!),
      );
    }
  }

  // void updateData(
  //     {required List<UpdateProductModel> product,
  //     required String orderId}) async {
  //   try {
  //     final url = Urls.updateProduct + orderId;
  //     final response = await ApiService.patchApi(url, product.first.toJson());
  //     final success = response["success"] ?? false;
  //     if (success) {
  //       Get.snackbar("Success", "Product updated successfully");
  //     } else {
  //       Get.snackbar("Error", "Failed to update product");
  //     }
  //   } catch (e) {
  //     appLogger("error in update data from pending order: $e");
  //   }
  // }

  // Fetch orders from the API
  // Future<void> fetchPending() async {
  //   try {
  //     String? token = await PrefsHelper.getToken();
  //     if (token.isEmpty) {
  //       Get.snackbar("Error", "User is not authenticated.");
  //       return;
  //     }

  //     update();

  //     // Call getApi to fetch pending orders
  //     var response = await ApiService.getApi(Urls.newPendingOrder);

  //     if (response == null) {
  //       Get.snackbar('Error', 'Failed to load orders');
  //       return;
  //     }

  //     debugPrint("Response: $response");

  //     // Handle the response when status code is 200 (success)
  //     orders.value = <MPendingOrders>[];
  //     if (response["data"] != null && response["data"] is List) {
  //       for (var element in response["data"]) {
  //         orders.add(MPendingOrders.fromJson(element));
  //       }
  //     }
  // MPendingOrders pendingResponse = MPendingOrders.fromJson(data);

  // if (pendingResponse.success == true) {
  //   orders.clear();

  //   for (var offer in pendingResponse.data) {
  //     // Iterate through products within each Datum entry
  //     var products = offer.product
  //         .map((product) => Product(
  //               productId: ProductId(
  //                 id: product.productId.id,
  //                 name: product.productId.name,
  //                 unit: product.productId.unit,
  //                 quantity: product.productId.quantity,
  //                 additionalInfo: product.productId.additionalInfo,
  //               ),
  //               availability: product.availability,
  //               price: product.price,
  //               id: product.id,
  //             ))
  //         .toList();

  //     orders.add(
  //       Datum(
  //         id: offer.id,
  //         retailer: offer.retailer,
  //         status: offer.status,
  //         createdAt: offer.createdAt,
  //         updatedAt: offer.updatedAt,
  //         product: products,
  //         wholeSeller: offer.wholeSeller,
  //         v: offer.v,
  //       ),
  //     );

  //     else {
  //       Get.snackbar('Error', 'Failed to load orders');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while fetching orders');
  //     appLogger("Error fetching orders: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }

  // Increment the quantity
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
    'Cup',
    'Other',
  ];

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

  // Validate input and handle product creation
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

      print(
          'Product: ${productNameController.text}, Unit: ${unitController.text}, Quantity: ${quantity.value}, Additional Info: ${additionalInfoController.text}');

      Get.offAllNamed(AppRoutes.retailerFindWholeSellerScreen);
    }
  }

  void setSelectedUnit(String? value) {
    selectedUnit.value = value ?? 'pcs';
  }

  void updateProduct(String id) async {
    try {
      final url = Urls.updateSingleProduct + id;
      final response = await ApiService.patchApi(url, {
        "productName": productNameController.text,
        "unit": selectedUnit.value,
        "quantity": quantity.value,
        "additionalInfo": additionalInfoController.text
      });
      final index = products.indexWhere((p) => p.id == id);
      if (index != -1) {
        products[index].productName = productNameController.text;
        products[index].unit = selectedUnit.value;
        products[index].quantity = quantity.value;
        products[index].additionalInfo = additionalInfoController.text;
        // update();
        products.refresh();
      }

      appLogger(response);
      //fetchPending();
      update();
      if (response != null) {
        Get.snackbar("Success", "Updated Successfully");
      }
      productNameController.clear();
      unitController.clear();
      additionalInfoController.clear();
    } catch (e) {
      appLogger(e);
    }
  }

  Future<void> startVoiceRecognition(bool isProduct) async {
    var status = await Permission.microphone.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    if (status.isGranted) {
      stt.SpeechToText speechToText = stt.SpeechToText();
      String currentLocaleId = 'en_US';
      bool available = await speechToText.initialize(
        onStatus: (status) {
          debugPrint('Speech status: $status');
          isListening.value = speechToText.isListening;
        },
        onError: (error) {
          debugPrint('Speech error: $error');
          isListening.value = false;
        },
      );

      if (available) {
        isListening.value = true;
        speechToText.listen(
          onResult: (result) {
            lastWords.value = result.recognizedWords;
            isProduct
                ? productNameController.text = lastWords.value
                : additionalInfoController.text = lastWords.value;
          },
          listenFor:
              const Duration(seconds: 60), // ⬅ Increase the duration here
          pauseFor: const Duration(seconds: 3),
          localeId: currentLocaleId,
        );
      } else {
        isListening.value = false;
        stt.SpeechToText().stop();
        debugPrint("The user has denied the use of speech recognition.");
      }
    } else {
      debugPrint("Microphone permission denied.");
    }
  }

  void stopVoiceRecognition() {
    isListening.value = false;
    stt.SpeechToText().stop();
  }
  // void showDeleteOrderDialog(BuildContext context, String orderId) {
  //   showCustomPopup(
  //     context,
  //     [
  //       Align(
  //         alignment: Alignment.centerRight,
  //         child: IconButtonWidget(
  //           onTap: () => Get.back(),
  //           icon: AppIconsPath.closeIcon,
  //           size: 20,
  //           color: AppColors.black,
  //         ),
  //       ),
  //       const SpaceWidget(spaceHeight: 16),
  //       const Center(
  //         child: TextWidget(
  //           text: AppStrings.areYouSure,
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           fontColor: AppColors.primaryBlue,
  //         ),
  //       ),
  //       const SpaceWidget(spaceHeight: 2),
  //       const Center(
  //         child: TextWidget(
  //           text: AppStrings.deleteDesc,
  //           fontSize: 15,
  //           fontWeight: FontWeight.w500,
  //           fontColor: AppColors.onyxBlack,
  //         ),
  //       ),
  //       const SpaceWidget(spaceHeight: 20),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 32),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Expanded(
  //               flex: 1,
  //               child: OutlinedButtonWidget(
  //                 onPressed: () => Get.back(),
  //                 label: AppStrings.no,
  //                 backgroundColor: AppColors.white,
  //                 buttonWidth: 120,
  //                 buttonHeight: 36,
  //                 textColor: AppColors.primaryBlue,
  //                 borderColor: AppColors.primaryBlue,
  //                 fontSize: 14,
  //               ),
  //             ),
  //             const SpaceWidget(spaceWidth: 16),
  //             Expanded(
  //               flex: 1,
  //               child: ButtonWidget(
  //                 onPressed: () async {
  //                   final url = "${Urls.deletePending}$orderId";
  //                   try {
  //                     final response = await ApiService.deleteApi(url, {});
  //                     appLogger(response.body);
  //                     final body = jsonDecode(response.body);
  //                     if (response.statusCode == 200) {
  //                       fetchPending();
  //                       Get.snackbar("Success", "Deleted Succesfully");
  //                       Get.back();
  //                     } else {
  //                       Get.snackbar("Error", body["message"]);
  //                     }
  //                   } catch (e) {
  //                     appLogger(e);
  //                     Get.snackbar("Error", e.toString());
  //                   }
  //                 },
  //                 label: AppStrings.yes,
  //                 backgroundColor: AppColors.primaryBlue,
  //                 buttonWidth: 120,
  //                 buttonHeight: 36,
  //                 fontSize: 14,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SpaceWidget(spaceHeight: 20),
  //     ],
  //   );
  // }
}
