import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/retailer/retailer_home/delete_order_model.dart';
import 'package:inventory_app/models/retailer/retailer_home/get_orders_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/controller/find_wholesaler_controller.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';

class RetailerSavedOrderScreenController extends GetxController {
  var selectedProducts = <bool>[].obs;
  var token = ''.obs;
  var selectAll = false.obs;
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;
  var orders = <Product>[].obs;
  var selectedOrderProducts = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // Fetch orders from the API
  Future<void> fetchOrders() async {
    try {
      // Retrieve the token from the preferences
      String? token = await PrefsHelper.getToken();

      // Check if the token is empty or not
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }

      update();

      var response = await ApiService.getApi(Urls.getAllOrders);

      if (response != null) {
        ProductResponse orderResponse = ProductResponse.fromJson(response);

        if (orderResponse.success) {
          orders.assignAll(orderResponse.data);

          selectedProducts
              .assignAll(List<bool>.generate(orders.length, (index) => false));
        } else {
          Get.snackbar('Error', orderResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to load orders');
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
      String deleteUrl = "${Urls.deleteOrder}/$id";
      var response = await ApiService.deleteApi(deleteUrl, {});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        MDeleteOrder deleteResponse = MDeleteOrder.fromJson(data);

        if (deleteResponse.success) {
          int indexToRemove = orders.indexWhere((order) => order.id == id);
          if (indexToRemove != -1) {
            orders.removeAt(indexToRemove);
          }
          selectedProducts
              .assignAll(List.generate(orders.length, (index) => false));
          Get.snackbar('Success', deleteResponse.message);
        } else {
          Get.snackbar('Error', deleteResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to delete order: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error deleting order: $e");
      Get.snackbar('Error', 'An error occurred while deleting the order');
    } finally {
      deleteIsLoading(false);
      update();
    }
  }

  // Function to add an order to the list
  void addOrder(Product order) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      orders.insert(0, order); 
      selectedProducts.insert(
          0, false); 
      update(); 
    });
  }

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

    selectedOrderProducts
        .clear(); 
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

    Get.find<FindWholesalerController>()
        .setSelectedProductIds(selectedProductIds);

    Get.toNamed(AppRoutes.retailerFindWholeSellerScreen,
        arguments: {'selectedProductIds': selectedProductIds});
  }
}
