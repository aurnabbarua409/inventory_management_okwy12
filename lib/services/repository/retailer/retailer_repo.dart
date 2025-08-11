import 'package:inventory_app/models/new_version/get_confirm_model.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/models/new_version/get_pending_order_wholesaler_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_confirmed_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class RetailerRepo {
  ApiService apiService = ApiService();
  Future<List<GetPendingOrderModel>> getRetailers() async {
    List<GetPendingOrderModel> retailers = [];
    try {
      final response = await ApiService.getApi(Urls.newPendingOrder);

      if (response != null) {
        appLogger(response);
        if (response['data'] != null && response['data'] is List) {
          for (var element in response['data']) {
            appLogger("retailer pending data: $element");
            // appLogger("sarah");
            // appLogger(element.runtimeType);
            retailers.add(GetPendingOrderModel.fromJson(element));
          }
        }
        appLogger(retailers);
        return retailers;
      }
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   final List<MPendingOrders> orders = (data['data'])
      //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
      //       .toList();

      //   retailers.addAll(orders);
      // }
    } catch (e) {
      appLogger("pending order error: $e");
    }
    // appLogger("Find 2");
    // appLogger(retailers);
    return retailers;
  }

  Future<List<GetPendingOrderModel>> getRecieved() async {
    List<GetPendingOrderModel> recieved = [];
    try {
      final response = await ApiService.getApi(Urls.receivedOrdersRetailer);
      appLogger("Retailer received order: $response");
      if (response != null) {
        if (response['data'] != null && response['data'] is List) {
          for (var elementReceived in response['data']) {
            recieved.add(GetPendingOrderModel.fromJson(elementReceived));
          }
        }
      }
      appLogger("retailer after adding received: $recieved");
      return recieved;
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   final List<MPendingOrders> orders = (data['data'])
      //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
      //       .toList();

      //   retailers.addAll(orders);
      // }
    } catch (e) {
      appLogger("error fetching data from getReceived: $e");
    }
    return recieved;
  }
  // Future<GetConfirmModel> getConfirmed() async {
  //   try {
  //     final response = await ApiService.getApi(Urls.confirmedOrderRetailer);
  //     appLogger("response from confirmed order model: $response");
  //     if (response != null) {
  //       return (GetConfirmModel.fromJson(response['data']));
  //     }

  //     // if (response.statusCode == 200) {
  //     //   final data = json.decode(response.body);
  //     //   final List<MPendingOrders> orders = (data['data'])
  //     //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
  //     //       .toList();

  //     //   retailers.addAll(orders);
  //     // }

  //   } catch (e) {
  //     appLogger("Error while fetching confirmed order: $e");
  //   }

  //   return ;
  // }
  Future<List<GetPendingOrderModel>> getConfirmed() async {
    List<GetPendingOrderModel> confirmed = [];
    try {
      final response = await ApiService.getApi(Urls.confirmedOrderRetailer);
      appLogger("response from confirmed order model: $response");
      if (response != null) {
        if (response['data'] != null && response['data'] is List) {
          for (var elementReceived in response['data']) {
            confirmed.add(GetPendingOrderModel.fromJson(elementReceived));
          }
        }
      }
      return confirmed;
    } catch (e) {
      appLogger("Error while fetching confirmed order: $e");
    }

    return confirmed;
  }
}
