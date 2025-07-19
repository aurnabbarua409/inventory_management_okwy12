import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_confirmed_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ConfirmedOrderDetailsHistoryController extends GetxController {
  RxBool isLoading = true.obs;

  var ordersConfirmed = <Confirmed>[].obs;

  @override
  void onInit() {
    super.onInit();
    appLogger("running confirmed order");
    fetchConfirmed();
  }

  Future<void> fetchConfirmed() async {
    try {
      String? token = await PrefsHelper.getToken();
      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated.");
        return;
      }

      update();

      var response = await ApiService.getApi(Urls.confirmedOrders);

      if (response == null) {
        Get.snackbar('Error', 'Failed to load orders');
        return;
      }

      debugPrint("Response: $response");

      var data = response;
      MConfirmedOrders confirmedResponse = MConfirmedOrders.fromJson(data);

      if (confirmedResponse.success == true) {
        ordersConfirmed.clear(); // Clear any old data

        if (confirmedResponse.data.isEmpty) {
          Get.snackbar('No Orders', 'No confirmed orders found');
        }

        for (var offer in confirmedResponse.data) {
          var products = offer.product
              .map((productReceived) => ProductConfirmed(
                    productId: ConfirmedProductId(
                      id: productReceived.productId.id,
                      name: productReceived.productId.name,
                      unit: productReceived.productId.unit,
                      quantity: productReceived.productId.quantity,
                      additionalInfo: productReceived.productId.additionalInfo,
                    ),
                    availability: productReceived.availability,
                    price: productReceived.price.toDouble(),
                    id: productReceived.id,
                  ))
              .toList();

          ordersConfirmed.add(
            Confirmed(
              id: offer.id,
              retailer: offer.retailer,
              status: offer.status,
              createdAt: offer.createdAt,
              updatedAt: offer.updatedAt,
              product: products,
              wholeSeller: offer.wholeSeller,
              v: offer.v,
            ),
          );
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

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final fontRegular =
        await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final fontBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");

    final ttfRegular = pw.Font.ttf(fontRegular);
    final ttfBold = pw.Font.ttf(fontBold);

    try {
      // Add a page to the PDF document
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Text(
                  'Confirmed Orders',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: ttfBold),
                ),
                pw.SizedBox(height: 10),
                // Loop through the orders and create a table
                pw.ListView.builder(
                  itemCount: ordersConfirmed.length,
                  itemBuilder: (context, index) {
                    var order = ordersConfirmed[index];
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Order ID: ${order.id}',
                            style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.normal,
                                font: ttfRegular)),
                        pw.Text('Retailer: ${order.retailer}',
                            style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold,
                                font: ttfBold)),
                        pw.Text('Status: ${order.status}',
                            style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold,
                                font: ttfBold)),
                        pw.Text('Created At: ${order.createdAt}',
                            style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold,
                                font: ttfBold)),
                        pw.SizedBox(height: 5),
                        pw.Text('Products:'),
                        pw.ListView.builder(
                          itemCount: order.product.length,
                          itemBuilder: (context, productIndex) {
                            var product = order.product[productIndex];
                            return pw.Text(
                                'Product: ${product.productId.name}, Price: ${product.price}');
                          },
                        ),
                        pw.SizedBox(height: 15),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      );

      // Get the directory to save the PDF
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/confirmed_orders.pdf');

      // Save the PDF to the file
      await file.writeAsBytes(await pdf.save());

      // Optionally, open the PDF file
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate PDF: $e');
      debugPrint("Error generating PDF: $e");
    }
  }
}
