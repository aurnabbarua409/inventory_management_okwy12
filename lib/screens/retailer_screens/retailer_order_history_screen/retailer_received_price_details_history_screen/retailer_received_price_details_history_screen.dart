import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_recieved_model.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/retailer_received_price_details_history_controller.dart';

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
  bool isEditing = false;

  void showProductDetailsDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SpaceWidget(spaceWidth: 16),
            const Center(
              child: TextWidget(
                text: AppStrings.productDetails,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
            ),
            IconButtonWidget(
              onTap: () {
                Get.back();
              },
              icon: AppIconsPath.closeIcon,
              size: 16,
              color: AppColors.black,
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 4),
        const Divider(
          color: AppColors.greyLight,
          height: 1,
        ),
        const SpaceWidget(spaceHeight: 16),
        const TextWidget(
          text: "Augmentin 625 Tab",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 6),
        const TextWidget(
          text: "2 Roll",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 6),
        const TextWidget(
          text:
              "Please ensure the packaging is intact and sealed. The product should be stored in a cool and dry place. Urgent delivery is required by the end of the week.",
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.onyxBlack,
          textAlignment: TextAlign.start,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteLight,
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
                child: Obx(() {
                  return receivedController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          children: [
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
                                  _buildHeaderCell("SI", flex: 1),
                                  _buildHeaderCell("Product", flex: 2),
                                  _buildHeaderCell("Qty", flex: 1),
                                  _buildHeaderCell("Unit", flex: 1),
                                  _buildHeaderCell("Avail.", flex: 1),
                                  _buildHeaderCell("Price", flex: 1),
                                  _buildHeaderCell("Total", flex: 1),
                                ],
                              ),
                            ),
                            // Data Rows (Flatten orders list and pass products only)
                            ..._buildDataRows(
                              receivedController.ordersReceived
                                  .expand((received) => received.product)
                                  .toList(),
                            ),
                          ],
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
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
  List<Widget> _buildDataRows(List<ProductReceived> productsReceived) {
    if (productsReceived.isEmpty) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "No orders available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ];
    }

    return productsReceived.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      bool isPriceNotZero = item.price != "0";
      bool isAvailable = item.availability;

      return InkWell(
        onTap: () {
          showProductDetailsDialog(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              // Serial Number (index + 1)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    (index + 1).toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12 *
                          (MediaQuery.of(context).size.width > 600
                              ? 1.2
                              : 1), // Adjust text size based on screen width
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              // Product Name
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item.productId.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12 *
                          (MediaQuery.of(context).size.width > 600
                              ? 1.2
                              : 1), // Responsive font size
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              // Quantity
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: isPriceNotZero
                      ? SizedBox(
                          width: 12,
                          height: 20,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: item.productId.quantity.toString()),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: isEditing ? Colors.grey : Colors.grey,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 4),
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.onyxBlack,
                            ),
                            onChanged: (value) {
                              // Handle value change
                            },
                            enabled: isEditing,
                          ),
                        )
                      : Text(
                          item.productId.quantity.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                        ),
                ),
              ),
              // Unit
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item.productId.unit.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),

              // Availability
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    isAvailable ? Icons.check_circle : Icons.cancel,
                    size: 14,
                    color: isAvailable ? Colors.green : Colors.red,
                  ),
                ),
              ),
              // Price
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item.price.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              // Total
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item.price.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              // More Options
              SizedBox(
                width: 14,
                child: PopupMenuButton(
                  padding: EdgeInsets.zero,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.black,
                    size: 18,
                  ),
                  color: AppColors.white,
                  onSelected: (value) {
                    if (value == 1) {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text(AppStrings.edit),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
