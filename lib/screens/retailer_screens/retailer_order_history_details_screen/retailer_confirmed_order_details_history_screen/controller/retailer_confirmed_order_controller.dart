import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';

import 'package:inventory_app/utils/app_logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ConfirmedOrderDetailsHistoryController extends GetxController {
  RxBool isLoading = false.obs;

  // var confirmedData = <Confirmed>[].obs;
  final deliveryCharge = 5.00;
  final RxDouble totalPrice = 0.0.obs;
  final Rxn<GetPendingOrderModel> confirmedData = Rxn<GetPendingOrderModel>();
  @override
  void onInit() {
    super.onInit();
    appLogger("running confirmed order");
    fetchData();
    // fetchConfirmed();
    // if (kDebugMode) {
    //   ordersConfirmed.add(Confirmed(
    //       status: "Confirmed",
    //       id: "12",
    //       createdAt: DateTime.now(),
    //       updatedAt: DateTime.now(),
    //       product: [
    //         ProductConfirmed(
    //             productId: ConfirmedProductId(
    //                 id: "1",
    //                 name: "Keyboard",
    //                 unit: "pic",
    //                 quantity: 1,
    //                 additionalInfo: "Nothing"),
    //             availability: false,
    //             price: 120,
    //             id: "12")
    //       ],
    //       wholeSeller: WholeSeller(
    //           id: "1",
    //           name: "someone Wholesaler",
    //           email: "aurnab@email.com",
    //           storeInformation: StoreInformation(
    //               businessName: "businessName",
    //               businessCategory: "some",
    //               location: "Dhaka")),
    //       retailer: Retailer(
    //           id: "1",
    //           name: "Someone Retailer",
    //           email: "aurnab@email.com",
    //           storeInformation: StoreInformation(
    //               businessName: "Sopme",
    //               businessCategory: "pics",
    //               location: "Dhaka"))));
    // }
  }

  void fetchData() {
    try {
      final args = Get.arguments;
      appLogger("in confirmed data: $args");
      confirmedData.value = args['products'];
      appLogger(
          "After coming confirm data: ${confirmedData.value!.wholesaler!.name}");
    } catch (e) {
      appLogger("error fetching details confirmed order data: $e");
    }
  }

  // Future<void> fetchConfirmed() async {
  //   try {
  //     String? token = await PrefsHelper.getToken();
  //     if (token.isEmpty) {
  //       Get.snackbar("Error", "User is not authenticated.");
  //       return;
  //     }

  //     update();
  //     isLoading.value = true;
  //     var response = await ApiService.getApi(Urls.confirmedOrders);

  //     if (response == null) {
  //       Get.snackbar('Error', 'Failed to load orders');
  //       return;
  //     }
  //     isLoading.value = false;
  //     appLogger("Response: $response");

  //     var data = response;
  //     MConfirmedOrders confirmedResponse = MConfirmedOrders.fromJson(data);

  //     if (confirmedResponse.success == true) {
  //       ordersConfirmed.clear(); // Clear any old data

  //       if (confirmedResponse.data.isEmpty) {
  //         Get.snackbar('No Orders', 'No confirmed orders found');
  //       }

  //       for (var offer in confirmedResponse.data) {
  //         var products = offer.product
  //             .map((productReceived) => ProductConfirmed(
  //                   productId: ConfirmedProductId(
  //                     id: productReceived.productId.id,
  //                     name: productReceived.productId.name,
  //                     unit: productReceived.productId.unit,
  //                     quantity: productReceived.productId.quantity,
  //                     additionalInfo: productReceived.productId.additionalInfo,
  //                   ),
  //                   availability: productReceived.availability,
  //                   price: productReceived.price.toDouble(),
  //                   id: productReceived.id,
  //                 ))
  //             .toList();

  //         ordersConfirmed.add(
  //           Confirmed(
  //             id: offer.id,
  //             retailer: offer.retailer,
  //             status: offer.status,
  //             createdAt: offer.createdAt,
  //             updatedAt: offer.updatedAt,
  //             product: products,
  //             wholeSeller: offer.wholeSeller,
  //             v: offer.v,
  //           ),
  //         );
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Failed to load orders');
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'An error occurred while fetching orders');
  //     debugPrint("Error fetching orders: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }

  Future<pw.MemoryImage> _loadImageFromAssets(String path) async {
    final data = await rootBundle.load(path);
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final fontRegular =
        await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final fontBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");

    final ttfRegular = pw.Font.ttf(fontRegular);
    final ttfBold = pw.Font.ttf(fontBold);
    var totalPrice = 0;
    final pw.MemoryImage currencyIcon =
        await _loadImageFromAssets("assets/images/currencyIcon.png");
    List<List<dynamic>> tableData = [];
    final product = confirmedData.value!.product!;
    for (int i = 0; i < confirmedData.value!.product!.length; i++) {
      tableData.add([
        i + 1,
        product[i].productName,
        product[i].quantity,
        product[i].unit,
        product[i].price,
        (product[i].price! * product[i].quantity!)
      ]);
      totalPrice += (product[i].price! * product[i].quantity!);
    }
    try {
      pdf.addPage(pw.Page(
        build: (context) {
          return pw.Column(children: [
            pw.Text("Invoice",
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 25)),
            pw.SizedBox(height: 20),
            pw.Container(
                width: double.infinity,
                color: PdfColors.grey300,
                child: pw.Text("Retailer Details",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 15))),
            pw.Row(children: [
              pw.Text("Name:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(
                  confirmedData
                          .value?.retailer?.storeInformation?.businessname ??
                      "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Address:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(
                  confirmedData.value?.retailer?.storeInformation?.location ??
                      "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Phone:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(confirmedData.value?.retailer?.phone ?? "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.SizedBox(height: 15),
            pw.Container(
                width: double.infinity,
                color: PdfColors.grey300,
                child: pw.Text("Wholesaler Details",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 15))),
            pw.Row(children: [
              pw.Text("Name:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(
                  confirmedData
                          .value?.wholesaler?.storeInformation?.businessname ??
                      "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Address:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(
                  confirmedData.value?.wholesaler?.storeInformation?.location ??
                      "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Phone:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Text(confirmedData.value?.wholesaler?.phone ?? "N/A",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.SizedBox(height: 15),
            pw.TableHelper.fromTextArray(
                headers: ['SI', 'Product', 'Qty', 'Unit', 'Price', 'Total'],
                data: tableData,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellAlignment: pw.Alignment.center),
            // pw.Container(
            //     width: double.infinity,
            //     color: PdfColors.grey300,
            //     child: pw.Row(children: [
            //       pw.Text("SI", style: const pw.TextStyle(fontSize: 15)),
            //       pw.Spacer(),
            //       pw.Text("Product", style: const pw.TextStyle(fontSize: 15)),
            //       pw.Spacer(),
            //       pw.Text("Qty", style: const pw.TextStyle(fontSize: 15)),
            //       pw.Spacer(),
            //       pw.Text("Unit", style: const pw.TextStyle(fontSize: 15)),
            //       pw.Spacer(),
            //       pw.Text("Price", style: const pw.TextStyle(fontSize: 15)),
            //       pw.Spacer(),
            //       pw.Text("Total", style: const pw.TextStyle(fontSize: 15)),
            //     ])),
            // for (int i = 0; i < confirmedData.value!.product!.length; i++)
            //   pw.Row(children: [
            //     pw.Text("${i + 1}", style: const pw.TextStyle(fontSize: 15)),
            //     pw.Spacer(),
            //     pw.Text(confirmedData.value?.product?[i].productName ?? "N/A",
            //         style: const pw.TextStyle(fontSize: 15)),
            //     pw.Spacer(),
            //     pw.Text(
            //         confirmedData.value?.product?[i].quantity.toString() ?? "0",
            //         style: const pw.TextStyle(fontSize: 15)),
            //     pw.Spacer(),
            //     pw.Text(confirmedData.value?.product?[i].unit ?? "Kg",
            //         style: const pw.TextStyle(fontSize: 15)),
            //     pw.Spacer(),
            //     pw.Text("${confirmedData.value?.product?[i].price ?? 0}",
            //         style: const pw.TextStyle(fontSize: 15)),
            //     pw.Spacer(),
            //     pw.Text(
            //         "${(confirmedData.value?.product![i].quantity ?? 0) * (confirmedData.value!.product![i].price ?? 0)}",
            //         style: const pw.TextStyle(fontSize: 15)),
            //   ]),
            pw.SizedBox(height: 15),
            pw.Row(children: [
              pw.Text("Sub Total:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Image(currencyIcon, height: 12, width: 12),
              pw.Text("$totalPrice", style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Delivery Charge:",
                  style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Image(currencyIcon, height: 12, width: 12),
              pw.Text("$deliveryCharge",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
            pw.Row(children: [
              pw.Text("Grand Total:", style: const pw.TextStyle(fontSize: 15)),
              pw.SizedBox(width: 10),
              pw.Image(currencyIcon, height: 12, width: 12),
              pw.Text("${totalPrice + deliveryCharge}",
                  style: const pw.TextStyle(fontSize: 15))
            ]),
          ]);
        },
      ));

      // pdf.addPage(
      //   pw.Page(
      //     build: (pw.Context context) {
      //       return pw.Column(
      //         children: [
      //           pw.Text(
      //             'Confirmed Orders',
      //             style: pw.TextStyle(
      //                 fontSize: 24,
      //                 fontWeight: pw.FontWeight.bold,
      //                 font: ttfBold),
      //           ),
      //           pw.SizedBox(height: 10),
      //           // Loop through the orders and create a table
      //           pw.ListView.builder(
      //             itemCount: ordersConfirmed.length,
      //             itemBuilder: (context, index) {
      //               var order = ordersConfirmed[index];
      //               return pw.Column(
      //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                 children: [
      //                   pw.Text('Order ID: ${order.id}',
      //                       style: pw.TextStyle(
      //                           fontSize: 24,
      //                           fontWeight: pw.FontWeight.normal,
      //                           font: ttfRegular)),
      //                   pw.Text('Retailer: ${order.retailer?.name}',
      //                       style: pw.TextStyle(
      //                           fontSize: 24,
      //                           fontWeight: pw.FontWeight.bold,
      //                           font: ttfBold)),
      //                   pw.Text('Status: ${order.status}',
      //                       style: pw.TextStyle(
      //                           fontSize: 24,
      //                           fontWeight: pw.FontWeight.bold,
      //                           font: ttfBold)),
      //                   pw.Text(
      //                       'Created At: ${DateFormat('yyyy-MM-dd hh:mm a').format(
      //                         order.createdAt ?? DateTime.now(),
      //                       )}',
      //                       style: pw.TextStyle(
      //                           fontSize: 24,
      //                           fontWeight: pw.FontWeight.bold,
      //                           font: ttfBold)),
      //                   pw.SizedBox(height: 5),
      //                   pw.Text('Products:'),
      //                   pw.ListView.builder(
      //                     itemCount: order.product.length,
      //                     itemBuilder: (context, productIndex) {
      //                       var product = order.product[productIndex];
      //                       return pw.Text(
      //                           'Product: ${product.productId.name}, Price: ${product.price}');
      //                     },
      //                   ),
      //                   pw.SizedBox(height: 15),
      //                 ],
      //               );
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // );

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
