import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class RetailerRepo {
  ApiService apiService = ApiService();
  Future<List<GetPendingOrderModel>> getRetailers() async {
    List<GetPendingOrderModel> retailers = [];
    int page = 1;
    bool hasmore = true;
    try {
      while (hasmore) {
        final url = "${Urls.newPendingOrder}?page=$page";
        final response = await ApiService.getApi(url);

        if (response != null) {
          List<dynamic> data = response['data'];
          if (data.isEmpty) {
            hasmore = false;
          }
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
        }
        page++;
        appLogger('$page is called........................');
      }
      return retailers;
    } catch (e) {
      appLogger("pending order error: $e");
    }
    // appLogger("Find 2");
    // appLogger(retailers);
    return retailers;
  }

  Future<List<GetPendingOrderModel>> getRecieved() async {
    List<GetPendingOrderModel> recieved = [];
    int page = 1;
    bool hasmore = true;
    try {
      while (hasmore) {
        final url = "${Urls.receivedOrdersRetailer}?page=$page";
        final response = await ApiService.getApi(url);
        appLogger("Retailer received order: $response");
        if (response != null) {
          List<dynamic> data = response['data'];
          if (data.isEmpty) {
            hasmore = false;
          }
          if (response['data'] != null && response['data'] is List) {
            for (var elementReceived in response['data']) {
              recieved.add(GetPendingOrderModel.fromJson(elementReceived));
            }
          }
        }
        page++;
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
    int page = 1;
    bool hasmore = true;
    try {
      while (hasmore) {
        final url = "${Urls.confirmedOrderRetailer}?page=$page";
        final response = await ApiService.getApi(url);
        appLogger("response from confirmed order model: $response");
        if (response != null) {
          List<dynamic> data = response['data'];
          if (data.isEmpty) {
            hasmore = false;
          }
          if (response['data'] != null && response['data'] is List) {
            for (var elementReceived in response['data']) {
              confirmed.add(GetPendingOrderModel.fromJson(elementReceived));
            }
          }
        }
        page++;
      }
      return confirmed;
    } catch (e) {
      appLogger("Error while fetching confirmed order: $e");
    }

    return confirmed;
  }
}
