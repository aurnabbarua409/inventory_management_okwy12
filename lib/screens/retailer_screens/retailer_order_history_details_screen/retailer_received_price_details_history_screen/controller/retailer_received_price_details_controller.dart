import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/new_version/get_received_order_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerReceivedOrderDetailsHistoryController extends GetxController {
  var token = ''.obs;
  var selectAll = false.obs;
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;

  // Update orders list type to match the new model
  var ordersReceived = <Received>[].obs;

  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final RxList<Orders> products = <Orders>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    // fetchReceived();
    // if (kDebugMode) {
    //   ordersReceived.add(Received(
    //       id: "1",
    //       retailer: Retailer(
    //           id: "1",
    //           name: "Someone",
    //           email: "some@email.com",
    //           storeInformation: StoreInformation(
    //               businessName: "May be",
    //               businessCategory: "sos",
    //               location: "Dhaka")),
    //       product: [
    //         ProductReceived(
    //             productId: ReceivedProductId(
    //                 id: "1",
    //                 name: "keyboard",
    //                 unit: "pics",
    //                 quantity: 1,
    //                 additionalInfo: "best"),
    //             availability: false,
    //             price: 1200,
    //             id: "2")
    //       ],
    //       wholeSeller: WholeSeller(
    //           id: "1",
    //           name: "Codeb",
    //           email: "codeb@email.com",
    //           storeInformation: StoreInformation(
    //               businessName: "cofo",
    //               businessCategory: "busi",
    //               location: "Dhaka")),
    //       status: "pending",
    //       createdAt: DateTime.now(),
    //       updatedAt: DateTime.now(),
    //       v: 1));
    // }
  }

  void fetchData() {
    final arg = Get.arguments;
    products.value = arg['products'];
    appLogger(products);
  }

  void showProductDetailsDialog(BuildContext context, Orders item) {
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
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
            ),
            IconButtonWidget(
              onTap: () {
                Get.back();
              },
              icon: AppIconsPath.closeIcon,
              size: 16,
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
        TextWidget(
          text: item.product?.productName ?? "N/A",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 6),
        TextWidget(
          text: "Price: ${item.price}",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 6),
        // TextWidget(
        //   text: item.,
        //   fontSize: 13,
        //   fontWeight: FontWeight.w400,
        //   fontColor: AppColors.onyxBlack,
        //   textAlignment: TextAlign.start,
        // ),
      ],
    );
  }

  // Fetch orders from the API
  Future<void> fetchReceived() async {
    try {
      String? token = await PrefsHelper.getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }

      update();

      // Call getApi to fetch pending orders
      var response = await ApiService.getApi(Urls.receivedOrders);

      if (response == null) {
        Get.snackbar('Error', 'Failed to load orders');
        return;
      }
      appLogger("received price: $response");
      print("Response: $response");

      // Handle the response when status code is 200 (success)
      var data = response;
      MReceivedOrders receivedResponse = MReceivedOrders.fromJson(data);

      if (receivedResponse.success == true) {
        ordersReceived.clear();

        for (var offer in receivedResponse.data) {
          var products = offer.product
              .map((productReceived) => ProductReceived(
                    productId: ReceivedProductId(
                        id: productReceived.productId.id,
                        name: productReceived.productId.name,
                        unit: productReceived.productId.unit,
                        quantity: productReceived.productId.quantity,
                        additionalInfo:
                            productReceived.productId.additionalInfo),
                    availability: productReceived.availability,
                    price: productReceived.price.toDouble(),
                    id: productReceived.id,
                  ))
              .toList();

          ordersReceived.add(
            Received(
              id: offer.id,
              retailer: offer.retailer,
              status: offer.status,
              createdAt: offer.createdAt,
              updatedAt: offer.updatedAt,
              product: products,
              wholeSeller: offer.wholeSeller,
              v: offer.v,
            ),
          );
        }
      } else {
        Get.snackbar('Error', 'Failed to load orders');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching orders');
      print("Error fetching orders: $e");
    } finally {
      isLoading(false);
    }
  }

  void send() async {
    //need to implement later
    try {
      final response =
          await ApiService.patchApi(Urls.updateAllReceivedOrders, {});
      appLogger(response);
      Get.snackbar("Success ${response["success"]}", response['message']);
      Get.back();
      Get.back();
    } catch (e) {
      appLogger(e);
      Get.snackbar("Error", "Failed to update");
    }
  }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }

  // Observable quantity for increment and decrement
  var quantity = 1.obs;

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
    selectedUnit.value = value ?? 'Kg';
  }
}
