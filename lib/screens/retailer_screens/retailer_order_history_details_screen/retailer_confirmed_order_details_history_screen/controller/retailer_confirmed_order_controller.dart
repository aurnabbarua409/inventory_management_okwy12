import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';

import 'package:inventory_app/utils/app_logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ConfirmedOrderDetailsHistoryController extends GetxController {
  RxBool isLoading = false.obs;

  // var confirmedData = <Confirmed>[].obs;
  //  final deliveryCharge = 5.00;
  final RxDouble totalPrice = 0.0.obs;
  final Rxn<GetPendingOrderModel> confirmedData = Rxn<GetPendingOrderModel>();
  final List<Product> product = [];
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
      if (confirmedData.value?.product?.isNotEmpty ?? false) {
        confirmedData.value!.product!
            .sort((a, b) => a.createAt!.compareTo(b.createAt!));
      }

      var temp = confirmedData.value?.product ?? [];

      for (int i = 0; i < temp.length; i++) {
        if (temp[i].availability ?? false) {
          product.add(temp[i]);
        }
      }
      // for (int i = 0; i < (confirmedData.value?.product?.length ?? 0); i++) {
      //   confirmedData.value!.product!.removeAt(i);
      // }
      appLogger(
          "After coming confirm data: ${confirmedData.value!.wholesaler!.name}");
    } catch (e) {
      appLogger("error fetching details confirmed order data: $e");
    }
  }

  String formatPrice(double value) {
    final formatter = NumberFormat('#,###');
    return formatter.format(value);
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

  Future<pw.MemoryImage> _loadImageFromAssets(String path) async {
    final data = await rootBundle.load(path);
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    // final fontRegular =
    //     await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    // final fontBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");

    // final ttfRegular = pw.Font.ttf(fontRegular);
    // final ttfBold = pw.Font.ttf(fontBold);
    var totalPrice = 0.0;
    final pw.MemoryImage currencyIcon =
        await _loadImageFromAssets("assets/images/currencyIcon.png");
    List<List<String>> tableData = [];

    for (int i = 0; i < product.length; i++) {
      tableData.add([
        (i + 1).toString(),
        product[i].productName ?? "N/A",
        product[i].quantity.toString(),
        product[i].unit ?? "pics",
        product[i].price.toString(),
        ((product[i].price ?? 0) * (product[i].quantity ?? 1)).toString()
      ]);
      totalPrice += ((product[i].price ?? 0) * (product[i].quantity ?? 1));
    }
    try {
      for (int i = 0; i < tableData.length; i = i == 0 ? i + 18 : i + 26) {
        final endIndex = min(i == 0 ? i + 18 : i + 26, tableData.length);
        pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(children: [
              pw.Text("Invoice",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 25)),
              pw.Row(children: [
                pw.Text(
                    confirmedData.value?.id!
                            .substring(confirmedData.value!.id!.length - 7) ??
                        "N/A",
                    style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                pw.Spacer(),
                pw.Text(
                    confirmedData.value!.updatedAt != null
                        ? DateFormat('yyyy-MM-dd EEE hh:mm a').format(
                            DateTime.parse(
                                confirmedData.value!.updatedAt.toString()))
                        : "N/A",
                    style: pw.TextStyle(fontStyle: pw.FontStyle.italic))
              ]),
              pw.SizedBox(height: 20),
              if (i < 18) ...[
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
                      confirmedData.value?.retailer?.storeInformation
                              ?.businessname ??
                          "N/A",
                      style: const pw.TextStyle(fontSize: 15))
                ]),
                pw.Row(children: [
                  pw.Text("Address:", style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(width: 10),
                  pw.Text(
                      confirmedData
                              .value?.retailer?.storeInformation?.location ??
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
                      confirmedData.value?.wholesaler?.storeInformation
                              ?.businessname ??
                          "N/A",
                      style: const pw.TextStyle(fontSize: 15))
                ]),
                pw.Row(children: [
                  pw.Text("Address:", style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(width: 10),
                  pw.Text(
                      confirmedData
                              .value?.wholesaler?.storeInformation?.location ??
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
                pw.Row(children: [
                  pw.Spacer(),
                  pw.Text("Grand Total:",
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 10),
                  pw.Image(currencyIcon, height: 12, width: 12),
                  pw.Text(formatPrice(totalPrice),
                      style: const pw.TextStyle(fontSize: 15))
                ]),
                pw.SizedBox(height: 15),
              ],
              pw.TableHelper.fromTextArray(
                  headers: ['SI', 'Product', 'Qty', 'Unit', 'Price', 'Total'],
                  data: tableData.sublist(i, endIndex),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration:
                      const pw.BoxDecoration(color: PdfColors.grey300),
                  cellAlignment: pw.Alignment.center),
            ]);
          },
        ));
      }

      // Get the directory to save the PDF
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/confirmed_orders.pdf');
      appLogger("File generated suucessfully: ${file.path}");
      // Save the PDF to the file
      final pdfBytes = await pdf.save();
      appLogger("PDF byte length: ${pdfBytes.length}");

      if (pdfBytes.isEmpty) {
        appLogger("PDF is empty — likely an error during generation");
      } else {
        await file.writeAsBytes(pdfBytes);
        final result = await OpenFile.open(file.path);
        appLogger("OpenFile result: ${result.message}");
      }

      appLogger("File saved");
      // Optionally, open the PDF file
      await OpenFile.open(file.path);
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate PDF: $e');
      appLogger("Error in confirm order generate page: $e");
      // debugPrint("Error generating PDF: $e");
    }
  }
}
