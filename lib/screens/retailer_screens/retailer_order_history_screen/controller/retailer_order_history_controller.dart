import 'package:get/get.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_confirmed_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/services/repo/retailer/retailer_repo.dart';
import 'package:inventory_app/utils/app_logger.dart';

class RetailerOrderHistoryController extends GetxController {
  //RxList<MPendingOffers> pendingOrders = <MPendingOffers>[].obs;
  RetailerRepo retailerRepo = RetailerRepo();

  RxBool isLoading = false.obs;
  RxList<Datum> pendingOrders = <Datum>[].obs;
  RxList<Received> receivedOrders = <Received>[].obs;
  RxList<Confirmed> confirmedOrders = <Confirmed>[].obs;

  Future<void> fetchPendingOrders() async {
    isLoading.value = true; // Show loading indicator
    try {
      var data = await retailerRepo.getRetailers();
      appLogger("fetching pending order: $data");
      pendingOrders.value = data;
    } catch (e) {
      appLogger(e);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Fetch Received Orders
  Future<void> fetchReceivedOrders() async {
    isLoading.value = true; // Show loading indicator
    try {
      var recievedData = await retailerRepo.getRecieved();
      appLogger("fetching received data: $recievedData");
      receivedOrders.value = recievedData;
    } catch (e) {
      appLogger(e);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Fetch Confirmed Orders
  Future<void> fetchConfirmedOrders() async {
    isLoading.value = true; // Show loading indicator
    try {
      var confirmedData = await retailerRepo.getConfirmed();
      appLogger("fetching confirm order: $confirmedData");
      confirmedOrders.value = confirmedData;
    } catch (e) {
      appLogger(e);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  @override
  void onInit() {
    fetchPendingOrders();
    fetchReceivedOrders();
    fetchConfirmedOrders();
    super.onInit();
  }
}
