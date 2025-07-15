import 'package:inventory_app/models/retailer/order_history/retailer_confirmed_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class RetailerRepo {
  ApiService apiService = ApiService();
  Future<List<Datum>> getRetailers() async {
    List<Datum> retailers = [];
    try {
      final response = await ApiService.getApi(Urls.pendingOrder);

      if (response != null) {
        if (response['data'] != null && response['data'] is List) {
          for (var element in response['data']) {
            // appLogger(element);
            // appLogger("sarah");
            // appLogger(element.runtimeType);
            retailers.add(Datum.fromJson(element));
          }
        }
      }
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   final List<MPendingOrders> orders = (data['data'])
      //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
      //       .toList();

      //   retailers.addAll(orders);
      // }
    } catch (e) {
      //appLogger(e);
    }
    // appLogger("Find 2");
    // appLogger(retailers);
    return retailers;
  }

  Future<List<Received>> getRecieved() async {
    List<Received> recieved = [];
    try {
      final response = await ApiService.getApi(Urls.receivedOrders);

      if (response != null) {
        if (response['data'] != null && response['data'] is List) {
          for (var elementReceived in response['data']) {
            appLogger(elementReceived);
            appLogger("sarah");
            appLogger(elementReceived.runtimeType);
            recieved.add(Received.fromJson(elementReceived));
          }
        }
      }
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   final List<MPendingOrders> orders = (data['data'])
      //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
      //       .toList();

      //   retailers.addAll(orders);
      // }
    } catch (e) {
      appLogger(e);
    }
    appLogger("Find 2");
    appLogger(recieved);
    return recieved;
  }

  Future<List<Confirmed>> getConfirmed() async {
    List<Confirmed> confirmed = [];
    try {
      final response = await ApiService.getApi(Urls.confirmedOrders);

      if (response != null) {
        if (response['data'] != null && response['data'] is List) {
          for (var elementConfirmed in response['data']) {
            appLogger(elementConfirmed);
            appLogger("sarah");
            appLogger(elementConfirmed.runtimeType);
            confirmed.add(Confirmed.fromJson(elementConfirmed));
          }
        }
      }
      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   final List<MPendingOrders> orders = (data['data'])
      //       .map((orderJson) => MPendingOrders.fromJson(orderJson))
      //       .toList();

      //   retailers.addAll(orders);
      // }
    } catch (e) {
      appLogger(e);
    }
    appLogger("Find 2");
    appLogger(confirmed);
    return confirmed;
  }
}
