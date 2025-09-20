import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_new_order_model.dart';
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

class RetailerOrderHistoryController extends GetxController {
  //RxList<MPendingOffers> pendingOrders = <MPendingOffers>[].obs;
  RetailerRepo retailerRepo = RetailerRepo();

  RxBool isLoading = false.obs;
  RxList<GetNewOrderModel> pendingOrders = <GetNewOrderModel>[].obs;
  RxList<GetNewOrderModel> receivedOrders = <GetNewOrderModel>[].obs;
  // RxList<Confirmed> confirmedOrders = <Confirmed>[].obs;
  RxList<GetNewOrderModel> confirmedOrders = <GetNewOrderModel>[].obs;
  Timer? refreshTimer;

  final isLoadingPending = false.obs;
  final isLoadingReceived = false.obs;
  final isLoadingConfirmed = false.obs;

  Future<void> fetchPendingOrders() async {
    update();
    // pendingOrders.clear();
    appLogger("trying to fetch orders");
    isLoadingPending.value = true; // Show loading indicator

    try {
      var data = await retailerRepo.getRetailers();
      appLogger("fetching pending order: $data");
      pendingOrders.value = data;
    } catch (e) {
      appLogger(e);
    } finally {
      isLoadingPending.value = false; // Hide loading indicator
    }
  }

  // Fetch Received Orders
  Future<void> fetchReceivedOrders() async {
    update();
    //  receivedOrders.clear();
    isLoadingReceived.value = true; // Show loading indicator
    try {
      var recievedData = await retailerRepo.getRecieved();
      appLogger("fetching received data: $recievedData");
      receivedOrders.value = recievedData;
      // if(kDebugMode){
      //   receivedOrders.add(GetReceivedOrderModel(wholeSaler: WholeSaler(id: "0", name: "From Debugmode", email: "N/A", image: "", createAt: DateTime.now().toString(), updateAt: DateTime.now().toString()), orders: [Orders(id: "0", product: )]))
      // }
    } catch (e) {
      appLogger(e);
    } finally {
      isLoadingReceived.value = false; // Hide loading indicator
    }
  }

  // Fetch Confirmed Orders
  Future<void> fetchConfirmedOrders() async {
    update();

    isLoadingConfirmed.value = true; // Show loading indicator
    try {
      var data = await retailerRepo.getConfirmed();
      appLogger("Fetching confirm order from retailer: $data");
      confirmedOrders.value = data;
    } catch (e) {
      appLogger("Error in fetching confirm order data: $e");
    } finally {
      isLoadingConfirmed.value = false; // Hide loading indicator
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
                        fetchPendingOrders();
                        fetchReceivedOrders();
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

  Future<void> initalize() async {
    fetchPendingOrders();
    fetchReceivedOrders();
    fetchConfirmedOrders();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initalize();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    refreshTimer?.cancel();
  }
}
