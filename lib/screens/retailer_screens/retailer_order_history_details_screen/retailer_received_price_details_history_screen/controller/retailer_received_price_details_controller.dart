import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
// import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class RetailerReceivedOrderDetailsHistoryController extends GetxController {
  var token = ''.obs;
  var selectAll = false.obs;
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;

  // Update orders list type to match the new model
  // var ordersReceived = <Received>[].obs;

  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final RxList<Product> products = <Product>[].obs;
  RxDouble grandtotal = 0.0.obs;
  final orderid = ''.obs;
  final Rxn<Wholesaler> wholesaler = Rxn<Wholesaler>();
  final isConfirmedPressed = false.obs;
  final formKey = GlobalKey<FormState>();
  List<int> prevQuantity = [];
  @override
  void onInit() {
    super.onInit();
    fetchData();
    updateGrandTotal();
  }

  void fetchData() {
    try {
      final arg = Get.arguments;
      products.value = arg['products'];
      orderid.value = arg['id'];
      wholesaler.value = arg['wholesaler'];
      prevQuantity = List.generate(
        products.length,
        (index) => products[index].quantity ?? 0,
      );

      appLogger(products);
    } catch (e) {
      appLogger(e);
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
              text: "Available:",
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
              text: ((item.quantity ?? 1) * (item.price ?? 0)).toString(),
              fontSize: 14,
              fontColor: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }

  // Fetch orders from the API
  // Future<void> fetchReceived() async {
  //   try {
  //     String? token = await PrefsHelper.getToken();
  //     if (token.isEmpty) {
  //       Get.snackbar("Error", "User is not authenticated.");
  //       return;
  //     }

  //     update();

  //     // Call getApi to fetch pending orders
  //     var response = await ApiService.getApi(Urls.receivedOrders);

  //     if (response == null) {
  //       Get.snackbar('Error', 'Failed to load orders');
  //       return;
  //     }
  //     appLogger("received price: $response");
  //     print("Response: $response");

  //     // Handle the response when status code is 200 (success)
  //     var data = response;
  //     MReceivedOrders receivedResponse = MReceivedOrders.fromJson(data);

  //     if (receivedResponse.success == true) {
  //       ordersReceived.clear();

  //       for (var offer in receivedResponse.data) {
  //         var products = offer.product
  //             .map((productReceived) => ProductReceived(
  //                   productId: ReceivedProductId(
  //                       id: productReceived.productId.id,
  //                       name: productReceived.productId.name,
  //                       unit: productReceived.productId.unit,
  //                       quantity: productReceived.productId.quantity,
  //                       additionalInfo:
  //                           productReceived.productId.additionalInfo),
  //                   availability: productReceived.availability,
  //                   price: productReceived.price.toDouble(),
  //                   id: productReceived.id,
  //                 ))
  //             .toList();

  //         ordersReceived.add(
  //           Received(
  //             id: offer.id,
  //             retailer: offer.retailer,
  //             status: offer.status,
  //             createdAt: offer.createdAt,
  //             updatedAt: offer.updatedAt,
  //             product: products,
  //             wholeSeller: offer.wholeSeller,
  //             v: offer.v,
  //           ),
  //         );
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Failed to load orders');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred while fetching orders');
  //     print("Error fetching orders: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> showContactDialog(BuildContext context) async {
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
            text:
                'Please contact your wholesaler to confirm quantity before you can proceed',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        Center(
          child: TextWidget(
            text:
                "Wholesaler Name: ${wholesaler.value?.storeInformation?.businessname ?? 'N/A'}",
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
                    send();
                    Get.back();
                    Get.back();
                  },
                  label: 'Okay',
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
                  onPressed: () async {
                    try {
                      final url = "tel:${wholesaler.value!.phone}";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    } catch (e) {
                      appLogger(e);
                    }
                  },
                  label: "Call Now",
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

  void send() async {
    //need to implement later
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].availability ?? false) {
        data.add(
            {"_id": products[i].id, "quantity": products[i].quantity ?? 0});
      }
      appLogger('added data: $data');
    }
    final updatedData = {"product": data};
    try {
      final url = Urls.updatereceiveToConfirm + orderid.value;
      final response = await ApiService.patchApi(url, updatedData);
      appLogger(response);
      if (response != null) {
        Get.snackbar("Success", "Order confirmed");
      } else {
        Get.snackbar("Failed", "Failed to update");
      }
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

  void updateGrandTotal() {
    grandtotal.value = 0;
    for (int i = 0; i < products.length; i++) {
      if (products[i].availability ?? false) {
        grandtotal.value +=
            ((products[i].price ?? 0.0) * (products[i].quantity ?? 1));
      }
    }
  }

  String formatPrice() {
    final formatter = NumberFormat('#,###');
    return formatter.format(grandtotal.value);
  }
}
