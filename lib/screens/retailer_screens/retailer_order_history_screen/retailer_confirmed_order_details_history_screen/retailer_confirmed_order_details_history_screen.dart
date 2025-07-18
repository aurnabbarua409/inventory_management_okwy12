import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/retailer_confirmed_order_details_history_screen/controller/retailer_confirmed_order_controller.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../../../widgets/icon_button_widget/icon_button_widget.dart';

class RetailerConfirmedOrderDetailsHistoryScreen extends StatefulWidget {
  const RetailerConfirmedOrderDetailsHistoryScreen({super.key});

  @override
  State<RetailerConfirmedOrderDetailsHistoryScreen> createState() =>
      _RetailerConfirmedOrderDetailsHistoryScreenState();
}

class _RetailerConfirmedOrderDetailsHistoryScreenState
    extends State<RetailerConfirmedOrderDetailsHistoryScreen> {
  // final ConfirmedOrderDetailsHistoryController confirmedController =
  //     Get.put(ConfirmedOrderDetailsHistoryController());

  double totalAmount = 0; // Class-level totalAmount

  @override
  Widget build(BuildContext context) {
    // Initialize ResponsiveUtils
    ResponsiveUtils.initialize(context);

    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: GetBuilder(
          init: ConfirmedOrderDetailsHistoryController(),
          builder: (confirmedController) => Column(
            children: [
              MainAppbarWidget(
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
                    const TextWidget(
                      text: AppStrings.orderDetails,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.white,
                    ),
                    const SpaceWidget(spaceWidth: 28),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Obx(() {
                  debugPrint(
                      'isLoading value: ${confirmedController.isLoading.value}');
                  if (confirmedController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          if (confirmedController.ordersConfirmed.isNotEmpty)
                            // Order Details Section
                            _buildDetailsList(
                              title: AppStrings.retailerDetails,
                              details: [
                                {
                                  AppStrings.name: confirmedController
                                      .ordersConfirmed.first.retailer?.name ?? '',
                                },
                                {
                                  AppStrings.email: confirmedController
                                      .ordersConfirmed.first.retailer?. email ?? '',
                                },
                                {
                                  AppStrings.orderDate: confirmedController
                                      .ordersConfirmed.first.createdAt
                                      .toString(),
                                },
                              ],
                            ),
                          SizedBox(height: ResponsiveUtils.height(16.0)),
          
                          // Wholesaler Details Section
                           _buildDetailsList(
                              title: AppStrings.wholesalerDetails,
                              details: [
                                {
                                  AppStrings.name: confirmedController
                                      .ordersConfirmed.first.wholeSeller?.name ?? '',
                                },
                                {
                                  AppStrings.email: confirmedController
                                      .ordersConfirmed.first.wholeSeller?. email ?? '',
                                },
                                {
                                  AppStrings.orderDate: confirmedController
                                      .ordersConfirmed.first.createdAt
                                      .toString(),
                                },
                              ],
                            ),
                        ],
                      ),
                    );
                  }
                }),
              ),
          
              SizedBox(height: ResponsiveUtils.height(16.0)),
          
              // Invoice Table
              _buildInvoiceTable(confirmedController),
              SizedBox(height: ResponsiveUtils.height(16.0)),
          
              // Summary and Download Button
              _buildSummarySection(confirmedController),
            ],
          ),
        ));
  }

  Widget _buildDetailsList({
    required String title,
    required List<Map<String, String>> details,
  }) {
    return Column(
      children: [
        // Header Row
        Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.height(12.0)),
          color: AppColors.tabBG,
          child: Row(
            children: [
              _buildTableCell(title, flex: 1, isHeader: true),
            ],
          ),
        ),
        // Details Rows
        ...details.map((entry) {
          final key = entry.keys.first;
          final value = entry.values.first;
          return Container(
            padding:
                EdgeInsets.symmetric(vertical: ResponsiveUtils.height(12.0)),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.greyLight2)),
            ),
            child: Row(
              children: [
                _buildTableCell("$key:", flex: 2, isHeader: false),
                _buildTableCell(value, flex: 3, isHeader: false),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInvoiceTable(ConfirmedOrderDetailsHistoryController confirmedController) {
    final invoiceItems = confirmedController.ordersConfirmed.isNotEmpty
        ? confirmedController.ordersConfirmed.first.product
            .map((product) => {
                  "product": product.productId.name,
                  "qty": product.productId.quantity.toString(),
                  "unit": product.productId.unit,
                  "price": product.price.toString(),
                  "total":
                      (product.price * product.productId.quantity).toString(),
                })
            .toList()
        : [];

    totalAmount = 0; // Reset totalAmount before calculation

    return Column(
      children: [
        // Table Header
        Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.width(12.0)),
          color: AppColors.tabBG,
          child: Row(
            children: [
              _buildTableCell("SI", flex: 1, isHeader: true),
              _buildTableCell("Product", flex: 2, isHeader: true),
              _buildTableCell("Qty", flex: 1, isHeader: true),
              _buildTableCell("Unit", flex: 1, isHeader: true),
              _buildTableCell("Price", flex: 1, isHeader: true),
              _buildTableCell("Total", flex: 1, isHeader: true),
            ],
          ),
        ),
        // Table Rows
        ...invoiceItems.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          totalAmount += double.tryParse(item["total"] ?? "0") ?? 0;
          return Container(
            padding:
                EdgeInsets.symmetric(vertical: ResponsiveUtils.width(12.0)),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.greyLight2)),
            ),
            child: Row(
              children: [
                _buildTableCell(index.toString(), flex: 1),
                _buildTableCell(item["product"] ?? "", flex: 2),
                _buildTableCell(item["qty"] ?? "", flex: 1),
                _buildTableCell(item["unit"] ?? "", flex: 1),
                _buildTableCellWithIcon(item["price"] ?? "", flex: 1),
                _buildTableCellWithIcon(item["total"] ?? "", flex: 1),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSummarySection(ConfirmedOrderDetailsHistoryController confirmedController) {
    final double grandTotal = totalAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Grand Total:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const ImageWidget(
                  imagePath: AppImagesPath.currencyIcon,
                  width: 11,
                  height: 11,
                ),
                Text(
                  grandTotal.toStringAsFixed(2),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: ResponsiveUtils.height(24)),
        // Download Button
        SizedBox(
          width: double.infinity,
          height: ResponsiveUtils.height(48),
          child: ButtonWidget(
            onPressed: () {
              confirmedController.generatePdf();
            },
            label: AppStrings.invoiceDownload,
            backgroundColor: AppColors.primaryBlue,
            buttonWidth: double.infinity,
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, {int flex = 1, bool isHeader = false}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(8.0)),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildTableCellWithIcon(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(8.0)),
        child: Row(
          children: [
            const ImageWidget(
              imagePath: AppImagesPath.currencyIcon,
              width: 11,
              height: 11,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
            // const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
