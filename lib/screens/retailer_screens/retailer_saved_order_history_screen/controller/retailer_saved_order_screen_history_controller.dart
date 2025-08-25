import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/new_version/get_all_order_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/controller/find_wholesaler_controller.dart';
import 'package:inventory_app/screens/widgets/item_counter_button.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/normal_text_field_widget/normal_text_field_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerSavedOrderScreenHistoryController extends GetxController {
  var selectedProducts = <bool>[].obs;
  var token = ''.obs;
  var selectAll = false.obs;
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;
  var orders = <GetAllOrderModel>[].obs;
  var selectedOrderProducts = <Map<String, String>>[].obs;
  final productNameController = TextEditingController();
  final unitController = TextEditingController();
  final additionalInfoController = TextEditingController();
  final RxInt quantity = 0.obs;
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
  void setSelectedUnit(String? value) {
    selectedUnit.value = value ?? 'pcs';
  }

  // Fetch orders from the API
  void fetchOrders() async {
    try {
      // Retrieve the token from the preferences
      String? token = await PrefsHelper.getToken();

      // Check if the token is empty or not
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }
      orders.clear();
      update();
      int page = 1;
      bool hasmore = true;
      while (hasmore) {
        final url = "${Urls.getAllHistory}?page=$page";
        var response = await ApiService.getApi(url);

        if (response != null) {
          final List<dynamic> data = response["data"];
          if (data.isEmpty) {
            hasmore = false;
          }
          // GetAllOrderModel orderResponse = GetAllOrderModel.fromJson(response);

          if (response['success'] ?? false) {
            // orders.assignAll(data);
            for (int i = 0; i < data.length; i++) {
              orders.add(GetAllOrderModel.fromJson(data[i]));
            }
            appLogger("fetching saved order: $orders");
            selectedProducts.assignAll(
                List<bool>.generate(orders.length, (index) => false));
          } else {
            Get.snackbar('Error', response['message']);
            break;
          }
        } else {
          Get.snackbar('Error', 'Failed to load orders');
          break;
        }
        page++;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching orders');
      debugPrint("Error fetching orders: $e");
    } finally {
      isLoading(false);
    }
  }

  // Delete Order Functionality
  Future<void> deleteRow(String id) async {
    deleteIsLoading(true);
    update();

    try {
      String deleteUrl = "${Urls.deleteProduct}/$id";
      var response = await ApiService.deleteApi(deleteUrl, {});
      int indexToRemove = orders.indexWhere((order) => order.id == id);
      selectedOrderProducts
          .removeWhere((item) => item['orderId'] == orders[indexToRemove].id);
      selectedProducts
          .assignAll(List.generate(orders.length, (index) => false));
      appLogger("after deleted: ${response.body}");

      fetchOrders();
      // String deleteUrl = "${Urls.deleteOrder}/$id";
      // var response = await ApiService.deleteApi(deleteUrl, {});

      // if (response.statusCode == 200) {
      //   var data = jsonDecode(response.body);
      //   MDeleteOrder deleteResponse = MDeleteOrder.fromJson(data);

      //   if (deleteResponse.success) {
      //     int indexToRemove = orders.indexWhere((order) => order.id == id);
      //     if (indexToRemove != -1) {
      //       orders.removeAt(indexToRemove);
      //     }
      //     selectedProducts
      //         .assignAll(List.generate(orders.length, (index) => false));
      //     Get.snackbar('Success', deleteResponse.message);
      //   } else {
      //     Get.snackbar('Error', deleteResponse.message);
      //   }
      // } else {
      //   Get.snackbar('Error', 'Failed to delete order: ${response.statusCode}');
      // }
    } catch (e) {
      appLogger("Error deleting order: $e");
      Get.snackbar('Error', 'An error occurred while deleting the order');
    } finally {
      deleteIsLoading(false);
      update();
    }
  }

  // Function to add an order to the list
  // void addOrder(CreateOrderResponseModel order) {
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     orders.insert(0, order);
  //     selectedProducts.insert(0, false);
  //     update();
  //   });
  // }

  // Function to toggle the checkbox state for an order
  void toggleCheckbox(int index) {
    selectedProducts[index] = !selectedProducts[index];
    selectAll.value = selectedProducts.every((item) => item);

    if (selectedProducts[index]) {
      // Add order ID to the list
      if (orders[index].id != null) {
        selectedOrderProducts.add({'orderId': orders[index].id!});
      }
      debugPrint("=================selected products:$selectedProducts");
      debugPrint(
          "================================selected:$selectedOrderProducts");
    } else {
      // Remove order ID from the list
      selectedOrderProducts
          .removeWhere((item) => item['orderId'] == orders[index].id);
    }
  }

  void toggleSelectAll(bool value) {
    selectAll.value = value;
    selectedProducts.assignAll(List.generate(orders.length, (index) => value));

    selectedOrderProducts.clear();
    if (value) {
      for (var order in orders) {
        if (order.id != null) {
          selectedOrderProducts.add({'orderId': order.id!});
        }
      }
    }
  }

  // Function to clear all selections
  void clearSelection() {
    selectAll.value = false;
    selectedProducts.fillRange(0, selectedProducts.length, false);
    selectedOrderProducts.clear();
  }

  // Function to share selected items
  void shareSelection() {
    List<String> selectedProductIds = selectedOrderProducts
        .map((product) => product['orderId'] ?? '')
        .where((id) => id.isNotEmpty)
        .toList();

    debugPrint("Selected product IDs: $selectedProductIds");
    Get.put(FindWholesalerController())
        .setSelectedProductIds(selectedProductIds);
    // Get.find<FindWholesalerController>()
    //     .setSelectedProductIds(selectedProductIds);

    Get.toNamed(AppRoutes.retailerFindWholeSellerScreen,
        arguments: {'selectedProductIds': selectedProductIds});
  }

  void showDeleteOrderDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () => Get.back(),
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
            text: 'Do you want to delete the selected products?',
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
                  onPressed: () => Get.back(),
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
                  onPressed: () async {
                    Get.back();
                    List<String> selectedOrderIds = [];
                    for (int i = 0; i < selectedProducts.length; i++) {
                      if (selectedProducts[i]) {
                        selectedOrderIds.add(orders[i].id!);
                      }
                    }

                    if (selectedOrderIds.isNotEmpty) {
                      for (String id in selectedOrderIds) {
                        await deleteRow(id);
                      }
                    }
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

  void showHistoryOrderDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () => Get.back(),
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
            text: 'Do you want to restore the selected products?',
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
                  onPressed: () => Get.back(),
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
                  onPressed: () async {
                    Get.back();
                    bool success = false;
                    List<String> selectedOrderIds = [];
                    for (int i = 0; i < selectedProducts.length; i++) {
                      if (selectedProducts[i]) {
                        selectedOrderIds.add(orders[i].id!);
                      }
                    }

                    if (selectedOrderIds.isNotEmpty) {
                      for (String id in selectedOrderIds) {
                        success = await updateProduct(id);
                      }
                    }
                    if (success) {
                      Get.snackbar(
                          'Success: $success', 'Product restored successfully',
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      Get.snackbar(
                          'Success: $success', 'Failed to restore product');
                    }
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

  void showHistoryOrderSingleDialog(
      BuildContext context, String id, String name) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () => Get.back(),
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
            text: 'Do you really want to restore the product: $name?',
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
                  onPressed: () => Get.back(),
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
                  onPressed: () async {
                    Get.back();
                    bool success = false;

                    success = await updateProduct(id);
                    if (success) {
                      Get.snackbar(
                          'Success: $success', 'Product restored successfully');
                    } else {
                      Get.snackbar(
                          'Success: $success', 'Failed to restore product');
                    }
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

  void showDeleteOrderSuccessfulDialog(BuildContext context) {
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
            text: AppStrings.deleteSuccessfulDesc,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  void showProductEditDialog(BuildContext context, String id) {
    showCustomPopup(
      context,
      [
        const SpaceWidget(spaceHeight: 20),
        const TextWidget(
          text: AppStrings.productName,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        NormalTextFieldWidget(
          controller: productNameController,
          hintText: 'Enter product name',
          maxLines: 1,
        ),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.unit,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        Obx(() {
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: const Text(
                'Select unit',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
              value: selectedUnit.value,
              items: units
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setSelectedUnit(value);
              },
              buttonStyleData: ButtonStyleData(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.strokeColor,
                    width: 0.75,
                  ),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.quantity2,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        Row(
          children: [
            ItemCount(
              initialValue: quantity.value,
              minValue: 0,
              onChanged: (value) {
                // Handle value change
                quantity.value = value;
              },
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.additionalInfo,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        NormalTextFieldWidget(
          controller: additionalInfoController,
          hintText: 'Add any instructions for your wholesaler',
          maxLines: 4,
        ),
        const SpaceWidget(spaceHeight: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButtonWidget(
              onPressed: () {
                updateProduct(id);
                Get.back();
                // setState(() {});
              },
              label: AppStrings.update,
              backgroundColor: AppColors.white,
              buttonWidth: MediaQuery.of(context).size.width * 0.7,
              buttonHeight: 50,
              textColor: AppColors.primaryBlue,
              borderColor: AppColors.primaryBlue,
              fontSize: 16,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  Future<bool> updateProduct(String id) async {
    try {
      final url = Urls.updateSingleProduct + id;
      final body = {"status": false};
      final response = await ApiService.patchApi(url, body);
      fetchOrders();
      final success = response['success'] ?? false;

      // if (success) {
      //   Get.snackbar('Success: $success', 'Product restored successfully');
      // } else {
      //   Get.snackbar('Success: $success', 'Failed to restore product');
      // }
      appLogger(response);
      return success;
    } catch (e) {
      appLogger(e);
      return false;
    }
  }

  @override
  void onClose() {
    productNameController.dispose();
    unitController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }
}
