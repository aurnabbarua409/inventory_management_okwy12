import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_received_price_details_history_screen/controller/retailer_received_price_details_controller.dart';

import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class RetailerReceivedPriceDetailsHistoryScreen extends StatefulWidget {
  const RetailerReceivedPriceDetailsHistoryScreen({super.key});

  @override
  State<RetailerReceivedPriceDetailsHistoryScreen> createState() =>
      _RetailerReceivedPriceDetailsHistoryScreenState();
}

class _RetailerReceivedPriceDetailsHistoryScreenState
    extends State<RetailerReceivedPriceDetailsHistoryScreen> {
  final RetailerReceivedOrderDetailsHistoryController receivedController =
      Get.put(RetailerReceivedOrderDetailsHistoryController());
  // bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: Center(
            child: Column(children: [
          MainAppbarWidget(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                    onTap: () {
                      Get.back();
                    },
                    icon: AppIconsPath.backIcon,
                    color: AppColors.white,
                    size: 22,
                  ),
                  TextWidget(
                    text: AppStrings.details,
                    fontSize: screenWidth > 600
                        ? 18
                        : 16, // Adjust font size for larger screens
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.white,
                  ),
                  const SpaceWidget(spaceWidth: 28),
                ],
              ),
            ),
          ),
          const SpaceWidget(spaceHeight: 16),

          // List/Table View
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          const TextWidget(
                            text: "${AppStrings.grandTotal}: ",
                            fontColor: AppColors.black,
                          ),
                          const ImageWidget(
                              height: 13,
                              width: 13,
                              imagePath: AppImagesPath.currencyIcon),
                          Obx(
                            () => TextWidget(
                              text: "${receivedController.grandtotal.value}",
                              fontColor: AppColors.black,
                            ),
                          )
                        ],
                      ),
                      const SpaceWidget(
                        spaceHeight: 10,
                      ),
                      // DataTable for items
                      Obx(() {
                        final products = receivedController.products;
                        if (products.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "No items available",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Form(
                            key: receivedController.formKey,
                            child: DataTable(
                              headingRowColor: WidgetStateColor.resolveWith(
                                (states) =>
                                    AppColors.primaryBlue.withOpacity(0.1),
                              ),
                              columnSpacing: 20,
                              dataRowHeight: 48,
                              headingRowHeight: 40,
                              columns: const [
                                DataColumn(
                                  label: Center(child: Text("Sl")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Product"),
                                  ),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Quantity")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Unit")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Availability")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Price")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Total")),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Center(child: Text("Action")),
                                  numeric: false,
                                ),
                              ],
                              rows: List.generate(products.length, (index) {
                                final item = products[index];
                                final price = item.price ?? 0;
                                final quantity = item.quantity ?? 0;
                                final total = price * quantity;

                                return DataRow(cells: [
                                  DataCell(
                                    Center(
                                      child: Text("${index + 1}"),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.productName ?? "N/A",
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Container(
                                        width: 60,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: TextFormField(
                                          initialValue: quantity.toString(),
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 8),
                                            errorStyle: TextStyle(
                                                fontSize: 10,
                                                color: Colors.red),
                                          ),
                                          style: const TextStyle(fontSize: 12),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            int? newQty =
                                                int.tryParse(value ?? '');
                                            if (newQty == null || newQty <= 0) {
                                              return 'To be>0';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            int? newQty = int.tryParse(value);
                                            if (newQty != null && newQty > 0) {
                                              item.quantity = newQty;
                                              receivedController.products[index]
                                                  .quantity = newQty;
                                              receivedController
                                                  .updateGrandTotal();
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(item.unit ?? "kg"),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Icon(
                                        (item.availability ?? false)
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: (item.availability ?? false)
                                            ? Colors.green
                                            : Colors.red,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(price.toString()),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text((item.price != null &&
                                              item.quantity != null)
                                          ? (item.price! * item.quantity!)
                                              .toString()
                                          : "0"),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: PopupMenuButton<int>(
                                        icon: const Icon(Icons.more_vert,
                                            size: 18),
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 1,
                                            child: Text('View Datails'),
                                          ),
                                          const PopupMenuItem(
                                            value: 2,
                                            child: Text('Delete'),
                                          ),
                                        ],
                                        onSelected: (value) async {
                                          if (value == 1) {
                                            receivedController
                                                .showProductDetailsDialog(
                                                    context, item);
                                          }
                                          if (value == 2) {
                                            final url =
                                                Urls.deleteProduct + item.id!;
                                            final response =
                                                await ApiService.deleteApi(
                                                    url, {});
                                            appLogger(response);

                                            // Remove the item from the controller's products list
                                            receivedController.products
                                                .removeWhere((product) =>
                                                    product.id == item.id);

                                            // Optionally, update grand total if needed
                                            receivedController
                                                .updateGrandTotal();

                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          ),
                        );
                      }),
                      const SpaceWidget(
                        spaceHeight: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonWidget(
                            buttonWidth: double.infinity,
                            label: "Confirm",
                            backgroundColor: AppColors.primaryBlue,
                            onPressed: () {
                              // Check if at least one product is available
                              bool anyAvailable = receivedController.products
                                  .any((product) =>
                                      product.availability ?? false);

                              if (!anyAvailable) {
                                Get.snackbar('Nothing is available right now!',
                                    'You can not confirm now');
                                return;
                              }

                              if (receivedController.formKey.currentState!
                                  .validate()) {
                                if (receivedController
                                    .isClickedConfirmed.value) {
                                  receivedController.send();
                                  Get.back();
                                } else {
                                  receivedController.isClickedConfirmed.value =
                                      true;
                                  receivedController.showContactDialog(context);
                                }
                              } else {
                                Get.snackbar(
                                    'Error', 'Please enter valid quantities');
                              }
                            }),
                      ),
                      const SpaceWidget(
                        spaceHeight: 30,
                      )
                    ],
                  ))),
        ])));
  }
}
