import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/retailer/find_wholesaler/get_wholesaler_model.dart';
import 'package:inventory_app/models/retailer/send_product_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:share_plus/share_plus.dart';

class FindWholesalerController extends GetxController {
  var selectedItems = <bool>[].obs;
  var wholesalers = <WholeSalerDetails>[].obs;
  var filteredWholesalers = <WholeSalerDetails>[].obs;
  var isSendingOrder = false.obs;
  var selectedOrderProducts = <Map<String, String>>[].obs;
  var selectedProductIds = <String>[];
  var pendingOrders = <Map<String, String>>[].obs;

  late TextEditingController searchController;
  final RxBool isLoading = false.obs;

  late ScrollController scrollController;
  final page = 1.obs;
  final hasMore = true.obs;

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchWholesalers();
    }
  }

  // Fetch wholesalers from the API
  Future<void> fetchWholesalers() async {
    if (isLoading.value || !hasMore.value) return;

    try {
      String? token = await PrefsHelper.getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }
      isLoading.value = true;
      var response =
          await ApiService.getApi("${Urls.getWholesaler}?page=${page.value}");
      isLoading.value = false;
      appLogger(response);
      if (response != null) {
        final mGetWholesalers = MGetWholesalers.fromJson(response);

        if (mGetWholesalers.success) {
          appLogger("data is coming from wholesaler");
          if (mGetWholesalers.data.isEmpty) {
            hasMore.value = false; // no more data
          } else {
            wholesalers.addAll(mGetWholesalers.data);
            filteredWholesalers.addAll(
                mGetWholesalers.data); // Assign all to filtered list initially
            page.value++;
            selectedItems.clear();
            selectedItems
                .addAll(List.generate(wholesalers.length, (_) => false));
          }
        } else {
          Get.snackbar('Error', mGetWholesalers.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to load wholesalers');
      }
    } catch (e) {
      appLogger("error in fetching wholesaler: $e");
      // Get.snackbar('Error', 'An error occurred while fetching wholesalers');
    }
  }

  // Filter wholesalers by hitting different API endpoints
  void filterWholesalers(String query) async {
    if (query.isEmpty) {
      filteredWholesalers.assignAll(wholesalers);
      return;
    }
    appLogger("Writing query: $query");
    print("This function call so far =-=-==-===-=-=-=--=-==-");

    // Check if query is numeric (to search by phone number)
    bool isPhoneNumber = _isPhoneNumber(query);

    try {
      if (isPhoneNumber) {
        var response =
            await ApiService.getApi('${Urls.getWholesaler}?phone=$query');

        _handleResponse(response);

        // if (filteredWholesalers.isEmpty) {
        //   _showShareAppDialog(query);
        // }
      } else if (_isValidEmail(query)) {
        var response =
            await ApiService.getApi('${Urls.getWholesaler}?email=$query');
        _handleResponse(response);
      } else {
        var response = await ApiService.getApi(
            '${Urls.getWholesaler}?storeInformation.businessName=$query');
        _handleResponse(response);
      }
      selectedItems
          .assignAll(List.generate(filteredWholesalers.length, (_) => false));
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while filtering wholesalers');
    }
  }

// Handle API response and update filtered wholesalers
  void _handleResponse(dynamic response) {
    if (response != null) {
      MGetWholesalers mGetWholesalers = MGetWholesalers.fromJson(response);
      if (mGetWholesalers.success) {
        filteredWholesalers.assignAll(mGetWholesalers.data);
        selectedItems
            .assignAll(List.generate(filteredWholesalers.length, (_) => false));
      } else {
        Get.snackbar('Error', mGetWholesalers.message);
      }
    } else {
      Get.snackbar('Error', 'Failed to filter wholesalers');
    }
  }

// Check if the query is a valid phone number
  bool _isPhoneNumber(String query) {
    // Simple check to see if the query is numeric and matches a phone number length
    return RegExp(r'^[0-9]+$').hasMatch(query) &&
        query.length >= 10 &&
        query.length <= 15;
  }

// Check if the query is a valid email
  bool _isValidEmail(String query) {
    // Regular expression to validate an email
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(query);
  }

  void _showShareAppDialog(String phoneNumber) {
    showCustomPopup(
      Get.context!,
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
            text: "Wholesaler not found",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        Center(
          child: TextWidget(
            text:
                "Would you like to share the app with the phone number $phoneNumber?",
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
                    Share.share(
                      AppStrings.share,
                      subject: AppStrings.fluttershare,
                    );
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
                    Share.share(
                      AppStrings.share, //'Check out this amazing content!',
                      subject:
                          AppStrings.fluttershare, // 'Flutter Share Example',
                    );
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

//    void _shareApp(String phoneNumber) {
//   //Logic for sharing the app, for example:
//   //You can use the share plugin or generate a link for the user to share.
//   String shareText = "Check out this app! You can find wholesalers for your needs. Phone number: $phoneNumber";
//   //For instance, using `share` package:
//   Share.share(shareText);
//   Get.snackbar('Share', 'App link shared with phone number $phoneNumber');
// }

  // Toggle selection for wholesalers
  void toggleSelection(int index, bool isSelected) {
    try {
      if (index < selectedItems.length) {
        selectedItems[index] = isSelected;
        selectedItems.refresh();
        update();
      }
      debugPrint("selected wholesalers:  $selectedItems");

      List<String> selectedWholesalerIds = [];
      for (int i = 0; i < filteredWholesalers.length; i++) {
        if (selectedItems[i]) {
          selectedWholesalerIds.add(filteredWholesalers[i].id);
        }
      }
      debugPrint("Updated selected wholesaler IDs: $selectedWholesalerIds");
    } catch (e) {
      appLogger(e);
    }
  }

  void deselect(int index) {
    if (index < selectedItems.length) {
      selectedItems[index] = false;
      selectedItems.refresh();
      update();
    }
  }

  void showSendOrderDialog(BuildContext context) {
    int selectedCount = selectedItems.where((item) => item).length;

    showCustomPopup(
      context,
      [
        const Center(
          child: Text(
            "Are you sure?",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            "Do you want to send orders to selected wholesalers?",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text("No", style: TextStyle(color: AppColors.red)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
                sendOrder(context);
                showSendOrderSuccessfulDialog(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue),
              child: const Text(
                "Yes",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void setSelectedProductIds(List<String> productIds) {
    selectedProductIds
        .assignAll(productIds); // Directly assign the product IDs to the RxList
    update();
  }

  Future<void> sendOrder(BuildContext context) async {
    List<String> selectedWholesalerIds = [];
    // final args = Get.arguments;
    // selectedProductIds = args['selectedProductIds'];

    for (int i = 0; i < filteredWholesalers.length; i++) {
      if (selectedItems[i]) {
        selectedWholesalerIds.add(filteredWholesalers[i].id);
      }
    }

    debugPrint("Final selected wholesaler IDs: $selectedWholesalerIds");

    if (selectedWholesalerIds.isEmpty) {
      Get.snackbar("No Selection", "Please select at least one wholesaler.");
      return;
    }

    if (selectedProductIds.isEmpty) {
      Get.snackbar("No Selection", "Please select at least one product.");
      return;
    }

    try {
      isSendingOrder.value = true;

      String? retailerId = PrefsHelper.userId;
      debugPrint("Retrieved Retailer ID: $retailerId");

      if (retailerId.isEmpty) {
        Get.snackbar("Error", "Retailer ID not found. Please log in again.");
        return;
      }

      String status = "Pending";

      // Create the list of order objects.
      // List<Map<String, dynamic>> orderList =
      //     selectedWholesalerIds.map((wholesalerId) {
      //   return {
      //     "retailer": retailerId,
      //     "wholeSeller": wholesalerId,
      //     "products": selectedProductIds,
      //     "status": status,
      //   };
      // }).toList();
      // final wholesalerIds = <String>[];
      // for (int i = 0; i < wholesalers.length; i++) {
      //   wholesalerIds.add(wholesalers[i].id);
      // }
      final List<Map<String, dynamic>> orders = [];
      for (int i = 0; i < selectedWholesalerIds.length; i++) {
        final orderList =
            SendProductModel(selectedProductIds, selectedWholesalerIds[i]);
        debugPrint("Request Body: $orderList");
        orders.add(orderList.toJson());
        // Send a single request with the list of order objects.
      }
      var response = await ApiService.postApiList(Urls.sendOrder, orders)
          .timeout(const Duration(seconds: 30));

      if (response != null && response['success'] == true) {
        appLogger("response after sending product to wholesaler: $response");
      }
      selectedItems
          .assignAll(List.generate(wholesalers.length, (index) => false));

      // var newOffer = response['data'];

      // for (var offer in newOffer) {
      //   addOffer(offer);
      // }
      selectedProductIds.clear();
      selectedWholesalerIds.clear();
      update();
    } catch (e) {
      Get.snackbar("Error", "An error occurred while sending the order: $e");
    } finally {
      isSendingOrder.value = false;
    }
  }

  void addOffer(Map<String, dynamic> newOffer) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pendingOrders.insert(
          0, newOffer.map((key, value) => MapEntry(key, value.toString())));
      update();
    });
  }

  // Future<String> getOrderStatus(String orderId) async {
  //   // Implement your logic to fetch the order status based on orderId.
  //   // For now, returning "Pending" as a placeholder.
  //   return "Pending";
  // }

  void showSendOrderSuccessfulDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        const Center(
          child: Icon(Icons.check_circle, color: Colors.green, size: 64),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Order Sent Successfully",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            "Your order has been sent to the selected wholesalers.",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackLight),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Get.back();
            // Get.offNamed(AppRoutes.retailerOrderHistoryScreen);
            Get.find<BottomNavbarController>().changeIndex(2);
            Get.toNamed(AppRoutes.bottomNavBar);
          },
          child: const Center(child: Text("Go to Order History")),
        ),
      ],
    );
  }
}
