import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/controller/retailer_confirmed_order_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/summary_item_widget.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import '../../../../widgets/icon_button_widget/icon_button_widget.dart';

class WholesalerConfirmedOrderDetailsScreen extends StatefulWidget {
  const WholesalerConfirmedOrderDetailsScreen({super.key});

  @override
  State<WholesalerConfirmedOrderDetailsScreen> createState() =>
      _RetailerConfirmedOrderDetailsHistoryScreenState();
}

class _RetailerConfirmedOrderDetailsHistoryScreenState
    extends State<WholesalerConfirmedOrderDetailsScreen> {
  final ConfirmedOrderDetailsHistoryController confirmedController =
      Get.put(ConfirmedOrderDetailsHistoryController());

  double totalAmount = 0; // Class-level totalAmount

  @override
  Widget build(BuildContext context) {
    // Initialize ResponsiveUtils
    ResponsiveUtils.initialize(context);
    appLogger("In confirm order details page");
    appLogger(confirmedController.confirmedData.value);
    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: GetBuilder(
          init: ConfirmedOrderDetailsHistoryController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
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
                Obx(() {
                  debugPrint(
                      'isLoading value: ${confirmedController.isLoading.value}');

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        if (confirmedController.confirmedData.value != null)
                          // Order Details Section
                          const SpaceWidget(
                            spaceHeight: 20,
                          ),
                        _buildDetailsList(
                          title: AppStrings.retailerDetails,
                          details: [
                            {
                              AppStrings.name: confirmedController.confirmedData
                                      .value?.retailer?.first.name ??
                                  '',
                            },
                            {
                              AppStrings.address: confirmedController
                                      .confirmedData
                                      .value
                                      ?.retailer
                                      ?.first
                                      .location ??
                                  '',
                            },
                            {
                              AppStrings.phone: confirmedController
                                      .confirmedData
                                      .value
                                      ?.retailer
                                      ?.first
                                      .phone ??
                                  ""
                            },
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Wholesaler Details Section
                        _buildDetailsList(
                          title: AppStrings.wholesalerDetails,
                          details: [
                            {
                              AppStrings.name: confirmedController.confirmedData
                                      .value?.wholesaler?.first.name ??
                                  '',
                            },
                            {
                              AppStrings.address: confirmedController
                                      .confirmedData
                                      .value
                                      ?.wholesaler
                                      ?.first
                                      .location ??
                                  '',
                            },
                            {
                              AppStrings.phone: confirmedController
                                      .confirmedData
                                      .value
                                      ?.wholesaler
                                      ?.first
                                      .phone ??
                                  ''
                            },
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Invoice Table
                        _buildInvoiceTable(),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Summary and Download Button
                        _buildSummarySection(),
                      ],
                    ),
                  );
                }),
              ],
            ),
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

  Widget _buildInvoiceTable() {
    final invoiceItems = confirmedController.confirmedData.value != null
        ? confirmedController.confirmedData.value?.product!
            .map((product) => {
                  "product": product.productName,
                  "qty": product.quantity.toString(),
                  "unit": product.unit,
                  "price": product.price.toString(),
                  "total": (product.price * product.quantity).toString(),
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
              _buildTableCell("Product", flex: 1, isHeader: true),
              _buildTableCell("Qty", flex: 1, isHeader: true),
              _buildTableCell("Unit", flex: 1, isHeader: true),
              _buildTableCell("Price", flex: 1, isHeader: true),
              _buildTableCell("Total", flex: 1, isHeader: true),
            ],
          ),
        ),
        // Table Rows
        ...invoiceItems!.asMap().entries.map((entry) {
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
                _buildTableCell(item["product"] ?? "", flex: 1),
                _buildTableCell(item["qty"] ?? "", flex: 1),
                _buildTableCell(item["unit"] ?? "", flex: 1),
                _buildTableCell(item["price"] ?? "", flex: 1),
                _buildTableCell(item["total"] ?? "", flex: 1),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSummarySection() {
    final double grandTotal = totalAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceWidget(
          spaceHeight: 10,
        ),
        SummaryItemWidget(title: AppStrings.grandTotal, price: grandTotal),
        SummaryItemWidget(
            title: AppStrings.deliveryCharge,
            price: confirmedController.deliveryCharge),
        SummaryItemWidget(
            title: AppStrings.grandTotal,
            price: grandTotal + confirmedController.deliveryCharge),
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
              overflow: TextOverflow.ellipsis),
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
