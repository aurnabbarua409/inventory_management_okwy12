import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_confirm_model.dart';
import 'package:inventory_app/models/new_version/get_pending_order_wholesaler_model.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/services/repository/retailer/retailer_repo.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class WholesalerOrderHistoryController extends GetxController {
  RetailerRepo retailerRepo = RetailerRepo();

  RxBool isLoading = false.obs;
  RxList<GetPendingOrderModel> newOrders = <GetPendingOrderModel>[].obs;
  RxList<GetPendingOrderModel> pendingOrders = <GetPendingOrderModel>[].obs;
  RxList<GetPendingOrderModel> confirmedOrders = <GetPendingOrderModel>[].obs;
  Timer? refreshTimer;
  Future<void> fetchNewOrders() async {
    update();
    newOrders.clear();
    isLoading.value = true; // Show loading indicator
    int page = 1;
    bool hasmore = true;
    try {
      while (hasmore) {
        final url = "${Urls.newPendingOrder}?page=$page";
        final response = await ApiService.getApi(url);
        List<dynamic> data = response['data'];
        if (data.isEmpty) {
          hasmore = false;
        }
        // var data = await retailerRepo.getRetailers();
        appLogger("fetching new order from wholesaler: $response");
        if (response['data'] != null && response['data'] is List) {
          for (var element in response["data"]) {
            newOrders.add(GetPendingOrderModel.fromJson(element));
          }
        }
        page++;
      }
      appLogger("Succesfully fetched new orders: $newOrders");
    } catch (e) {
      appLogger("error from fetching new order: $e");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Fetch Received Orders
  Future<void> fetchPendingOrders() async {
    update();
    pendingOrders.clear();
    isLoading.value = true; // Show loading indicator
    try {
      final response = await ApiService.getApi(
        Urls.pendingOrderWholesaler,
      );
      appLogger("fetching pending data from wholesaler: $response");
      final isSuccess = response['success'] ?? false;

      if (isSuccess) {
        if (response['data'] != null && response['data'] is List) {
          for (var element in response["data"]) {
            pendingOrders.insert(0, GetPendingOrderModel.fromJson(element));
          }
        }
      }
      // var recievedData = await retailerRepo.getRecieved();
      appLogger("fetching received order: $pendingOrders");
      // receivedOrders.value = recievedData;
    } catch (e) {
      appLogger("error fetching pending order -r: $e");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Fetch Confirmed Orders
  Future<void> fetchConfirmedOrders() async {
    update();
    confirmedOrders.clear();
    isLoading.value = true; // Show loading indicator
    try {
      var response = await ApiService.getApi(Urls.confirmedOrderWholesaler);
      appLogger("response from confirm order: $response");
      final isSuccess = response['success'] ?? false;

      if (isSuccess) {
        if (response['data'] != null && response['data'] is List) {
          for (var element in response["data"]) {
            confirmedOrders.insert(0, GetPendingOrderModel.fromJson(element));
          }
        }
      }
    } catch (e) {
      appLogger("error fetching confirmed order: $e");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  void showDeleteOrderDialog(BuildContext context, String orderId) {
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
            text: AppStrings.deleteDesc,
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
                    final url = "${Urls.deleteOrder}$orderId";
                    try {
                      final response = await ApiService.deleteApi(url, {});
                      appLogger(response.body);
                      final body = jsonDecode(response.body);
                      if (response.statusCode == 200) {
                        Get.back();
                        fetchNewOrders();
                        fetchPendingOrders();
                        fetchConfirmedOrders();
                        Get.snackbar("Success", "Deleted Succesfully");

                        return;
                      } else {
                        Get.snackbar("Error", body["message"]);
                      }
                    } catch (e) {
                      appLogger(e);
                      Get.snackbar("Error", e.toString());
                    }
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

  Future initialize() async {
    fetchNewOrders();
    fetchPendingOrders();
    fetchConfirmedOrders();
  }

  @override
  void onClose() {
    super.onClose();
    refreshTimer?.cancel();
  }
}
