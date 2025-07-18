import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/constants/app_colors.dart';

class WholesalerPendingOrderDetailController extends GetxController {
  var isLoading = true.obs;
  var deleteIsLoading = false.obs;

  // Update orders list type to match the new model
  var orders = <Datum>[].obs;

  // Method to fetch the pending product orders
  Future<void> fetchPendingProduct() async {
    try {
      String? token = await PrefsHelper.getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }

      // Call API to fetch pending orders
      var response = await ApiService.getApi(Urls.pendingOrder);

      if (response == null) {
        Get.snackbar('Error', 'Failed to load orders');
        return;
      }

      // Handle the response when status code is 200 (success)
      var data = response;
      MPendingOrders pendingResponse = MPendingOrders.fromJson(data);

      if (pendingResponse.success == true) {
        orders.clear();
        for (var offer in pendingResponse.data) {
          var products = offer.product
              .map((product) => Product(
                    productId: ProductId(
                      id: product.productId.id,
                      name: product.productId.name,
                      unit: product.productId.unit,
                      quantity: product.productId.quantity,
                      additionalInfo: product.productId.additionalInfo,
                    ),
                    availability: product.availability,
                    price: product.price,
                    id: product.id,
                    total: product.total,
                  ))
              .toList();
          orders.add(Datum(
            id: offer.id,
            retailer: offer.retailer,
            product: products,
            wholeSeller: offer.wholeSeller,
            status: offer.status,
            createdAt: offer.createdAt,
            updatedAt: offer.updatedAt,
            v: offer.v,
          ));
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

  // This method allows you to update specific product data like availability, price, and quantity.
  void updateProductData(int orderIndex, int productIndex, {bool? availability, double? price, int? quantity}) {
    // Access the product from the orders list
    var product = orders[orderIndex].product[productIndex];

    // Update availability if provided
    if (availability != null) {
      product.availability = availability;
    }

    // Update price if provided and recalculate total
    if (price != null) {
      product.price = price;
      product.calculateTotal(); // Recalculate the total if price changes
    }

    // Update quantity if provided and recalculate total
    if (quantity != null) {
      product.productId.quantity = quantity; // Update quantity in ProductId
      product.calculateTotal(); // Recalculate the total if quantity changes
    }

    // Notify listeners for changes
    update(); // Make the change observable to the UI
  }

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

  @override
  void onClose() {
    super.onClose();
  }
}
