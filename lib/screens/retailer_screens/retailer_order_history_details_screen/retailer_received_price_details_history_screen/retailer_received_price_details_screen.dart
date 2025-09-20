import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_received_price_details_history_screen/controller/retailer_received_price_details_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_received_price_details_history_screen/widgets/table_data_row.dart';
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ButtonWidget(
            buttonWidth: double.infinity,
            label: "Confirm",
            backgroundColor: AppColors.primaryBlue,
            onPressed: () {
              List<bool> isavailable = List.generate(
                receivedController.products.length,
                (index) => true,
              );
              for (int i = 0; i < receivedController.products.length; i++) {
                if (!(receivedController.products[i].availability ?? true)) {
                  isavailable[i] = false;
                }
              }
              if (isavailable.every((available) => available == false)) {
                Get.snackbar('Nothing is available right now!',
                    'You can not confirm now');
                return;
              }
              if (receivedController.isEditing
                  .any((isEditing) => isEditing == true)) {
                Get.snackbar(
                  'Hold on!',
                  'You have unsaved changes. Please save them before confirming.',
                  snackPosition: SnackPosition.TOP,
                );

                return;
              }
              if (receivedController.formKey.currentState!.validate()) {
                receivedController.send();
                Get.back();

                // Get.back();
              } else {
                Get.snackbar('Error', 'Please enter valid quantities');
              }
            }),
      ),
      body: Center(
        child: Column(
          children: [
            MainAppbarWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonWidget(
                      onTap: () {
                        Get.back();
                        // Get.delete<
                        //     RetailerReceivedOrderDetailsHistoryController>();
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
                              text: receivedController.formatPrice(),
                              fontColor: AppColors.black,
                            ),
                          )
                        ],
                      ),
                      const SpaceWidget(
                        spaceHeight: 10,
                      ),
                      // Header Row
                      Container(
                        color: AppColors.headerColor,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        // child: Row(
                        //   children: [
                        //     _buildHeaderCell("Sl", flex: 1),
                        //     _buildHeaderCell("Name", flex: 4),
                        //     _buildHeaderCell("Qty", flex: 1),
                        //     _buildHeaderCell("Unit", flex: 1),
                        //     _buildHeaderCell("Avail.", flex: 1),
                        //     _buildHeaderCell("Price", flex: 1),
                        //     _buildHeaderCell("Total", flex: 1),
                        //     const SpaceWidget(spaceWidth: 8),
                        //   ],
                        // ),
                        child: Row(
                          children: [
                            _buildHeaderCell("SI",
                                flex: 1,
                                padding: const EdgeInsets.only(left: 5)),
                            _buildHeaderCell("Product", flex: 2),
                            _buildHeaderCell("Qty", flex: 1),
                            _buildHeaderCell("Unit", flex: 1),
                            _buildHeaderCell("Avail", flex: 1),
                            _buildHeaderCell("Unit Price", flex: 1),
                            _buildHeaderCell("Total", flex: 1),
                            _buildHeaderCell("", flex: 1),
                          ],
                        ),
                      ),
                      // Data Rows (Flatten orders list and pass products only)
                      TableDataRow(
                        productsReceived: receivedController.products,
                        controller: receivedController,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text,
      {int flex = 1, EdgeInsetsGeometry? padding}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding ?? EdgeInsetsGeometry.zero,
        child: Text(
          text,
          softWrap: true,
          maxLines: null,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12 *
                (MediaQuery.of(context).size.width > 600
                    ? 1.2
                    : 1), // Scaling text based on screen width
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  // Function to build data rows
  // List<Widget> _buildDataRows(List<Orders> productsReceived) {
  //   if (productsReceived.isEmpty) {
  //     return [
  //       const Center(
  //         child: Padding(
  //           padding: EdgeInsets.all(20),
  //           child: Text(
  //             "No orders available",
  //             style: TextStyle(fontSize: 16, color: Colors.grey),
  //           ),
  //         ),
  //       ),
  //     ];
  //   }

  //   return productsReceived.asMap().entries.map((entry) {
  //     final index = entry.key;
  //     final item = entry.value;
  //     bool isPriceNotZero = item.price != "0";
  //     bool isAvailable = item.availability ?? false;
  //     int price = item.price ?? 1;
  //     int quantity = item.product?.quantity ?? 1;
  //     int total = price * quantity;

  //     return InkWell(
  //       onTap: () {
  //         showProductDetailsDialog(context, item);
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(vertical: 4),
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
  //         ),
  //         child: Row(
  //           children: [
  //             // Serial Number (index + 1)
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   (index + 1).toString(),
  //                   textAlign: TextAlign.left,
  //                   style: TextStyle(
  //                     fontSize: 12 *
  //                         (MediaQuery.of(context).size.width > 600
  //                             ? 1.2
  //                             : 1), // Adjust text size based on screen width
  //                     color: AppColors.onyxBlack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Product Name
  //             Expanded(
  //               flex: 2,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   item.product?.productName ?? "N/A",
  //                   textAlign: TextAlign.left,
  //                   style: TextStyle(
  //                     fontSize: 12 *
  //                         (MediaQuery.of(context).size.width > 600
  //                             ? 1.2
  //                             : 1), // Responsive font size
  //                     color: AppColors.onyxBlack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Quantity
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12),
  //                 child: isPriceNotZero
  //                     ? SizedBox(
  //                         width: 12,
  //                         height: 20,
  //                         child: TextFormField(
  //                           keyboardType: TextInputType.number,
  //                           controller: TextEditingController(
  //                               text: item.product?.quantity.toString()),
  //                           decoration: InputDecoration(
  //                             enabledBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey,
  //                               ),
  //                             ),
  //                             disabledBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                 color: Colors.transparent,
  //                               ),
  //                             ),
  //                             focusedBorder: OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                 color: isEditing ? Colors.grey : Colors.grey,
  //                               ),
  //                             ),
  //                             contentPadding: const EdgeInsets.symmetric(
  //                                 vertical: 0, horizontal: 4),
  //                           ),
  //                           style: const TextStyle(
  //                             fontSize: 10,
  //                             color: AppColors.onyxBlack,
  //                           ),
  //                           onChanged: (value) {
  //                             // Handle value change
  //                             try {
  //                               receivedController.products[index].product
  //                                   ?.quantity = int.parse(value);
  //                             } catch (e) {
  //                               appLogger(e);
  //                             }
  //                           },
  //                           enabled: isEditing,
  //                         ),
  //                       )
  //                     : Text(
  //                         item.product?.quantity.toString() ?? "0",
  //                         textAlign: TextAlign.left,
  //                         style: const TextStyle(
  //                           fontSize: 10,
  //                           color: AppColors.onyxBlack,
  //                         ),
  //                       ),
  //               ),
  //             ),
  //             // Unit
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   item.product?.unit ?? "kg",
  //                   textAlign: TextAlign.left,
  //                   style: const TextStyle(
  //                     fontSize: 10,
  //                     color: AppColors.onyxBlack,
  //                   ),
  //                 ),
  //               ),
  //             ),

  //             // Availability
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Icon(
  //                   isAvailable ? Icons.check_circle : Icons.cancel,
  //                   size: 14,
  //                   color: isAvailable ? Colors.green : Colors.red,
  //                 ),
  //               ),
  //             ),
  //             // Price
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   price.toString(),
  //                   textAlign: TextAlign.left,
  //                   style: const TextStyle(
  //                     fontSize: 10,
  //                     color: AppColors.onyxBlack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Total
  //             Expanded(
  //               flex: 1,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   total.toString(),
  //                   textAlign: TextAlign.left,
  //                   style: const TextStyle(
  //                     fontSize: 10,
  //                     color: AppColors.onyxBlack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // More Options
  //             SizedBox(
  //               width: 14,
  //               child: PopupMenuButton(
  //                 padding: EdgeInsets.zero,
  //                 style: const ButtonStyle(
  //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                   padding: WidgetStatePropertyAll(EdgeInsets.zero),
  //                   visualDensity: VisualDensity.compact,
  //                 ),
  //                 icon: const Icon(
  //                   Icons.more_vert,
  //                   color: AppColors.black,
  //                   size: 18,
  //                 ),
  //                 color: AppColors.white,
  //                 onSelected: (value) {
  //                   if (value == 1) {
  //                     setState(() {
  //                       isEditing = !isEditing;
  //                     });
  //                   }
  //                 },
  //                 itemBuilder: (context) => [
  //                   const PopupMenuItem(
  //                     value: 1,
  //                     child: Text(AppStrings.edit),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }).toList();
  // }
}
