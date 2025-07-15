import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/models/retailer/order_history/update_order_retailer_model.dart';
import 'package:inventory_app/screens/widgets/item_counter_button.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/normal_text_field_widget/normal_text_field_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'controller/retailer_pending_order_details_history_controller.dart';

class OrderDetailsController extends GetxController {
  var orderList = [
    {'sl': '01', 'product': 'Augmentin 625 Tab', 'qty': 2, 'unit': 'Rolls'},
    {'sl': '02', 'product': 'Coca-Cola 300ml', 'qty': 12, 'unit': 'Crates'},
    {'sl': '03', 'product': 'Maple Syrup 220ml', 'qty': 2, 'unit': 'Trucks'},
  ].obs;
}

class RetailerPendingOrderDetailsHistoryScreen extends StatefulWidget {
  const RetailerPendingOrderDetailsHistoryScreen({super.key});

  @override
  State<RetailerPendingOrderDetailsHistoryScreen> createState() =>
      _RetailerPendingOrderDetailsHistoryScreenState();
}

class _RetailerPendingOrderDetailsHistoryScreenState
    extends State<RetailerPendingOrderDetailsHistoryScreen> {
  final RetailerPendingOrderDetailsHistoryController pendingController =
      Get.put(RetailerPendingOrderDetailsHistoryController());

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
        TextWidget(
          text: pendingController.productNameController.text.isEmpty
              ? 'N/A'
              : pendingController.productNameController.text,
          fontSize: 14,
        ),
        const SpaceWidget(spaceHeight: 6),
        TextWidget(
          text: pendingController.additionalInfoController.text.isEmpty
              ? 'N/A'
              : pendingController.additionalInfoController.text,
          fontSize: 14,
        ),
      ],
    );
  }

  void showProductEditDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        const SpaceWidget(spaceHeight: 20),
        const TextWidget(
          text: AppStrings.productName,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        NormalTextFieldWidget(
          controller: pendingController.productNameController,
          hintText: 'Enter product name',
          maxLines: 1,
          suffixIcon: AppIconsPath.voiceIcon,
        ),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.unit,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        Obx(() {
          return DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: const Text(
                'Select unit',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
              value: pendingController.selectedUnit.value,
              items: pendingController.units
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                pendingController.setSelectedUnit(value);
              },
              buttonStyleData: ButtonStyleData(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.strokeColor,
                    width: 0.75,
                  ),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.quantity2,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        Row(
          children: [
            ItemCount(
              initialValue: 0,
              minValue: 0,
              onChanged: (value) {
                // Handle value change
              },
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 14),
        const TextWidget(
          text: AppStrings.additionalInfo,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        const SpaceWidget(spaceHeight: 10),
        NormalTextFieldWidget(
          controller: pendingController.additionalInfoController,
          hintText: 'Add any instructions for your wholesaler',
          maxLines: 4,
          suffixIcon: AppIconsPath.voiceIcon,
        ),
        const SpaceWidget(spaceHeight: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButtonWidget(
              onPressed: () {
                Get.back();
              },
              label: AppStrings.update,
              backgroundColor: AppColors.white,
              buttonWidth: 150,
              buttonHeight: 50,
              textColor: AppColors.primaryBlue,
              borderColor: AppColors.primaryBlue,
              fontSize: 16,
            ),
            const SpaceWidget(spaceWidth: 28),
          ],
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  void showDeleteOrderDialog(BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: TextWidget(
            text: AppStrings.areYouSure,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.deleteProductDesc,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButtonWidget(
                  onPressed: () {
                    Get.back();
                  },
                  label: AppStrings.no,
                  backgroundColor: AppColors.white,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  textColor: AppColors.primaryBlue,
                  borderColor: AppColors.primaryBlue,
                  fontSize: 14,
                ),
              ),
              const SpaceWidget(spaceWidth: 16),
              Expanded(
                flex: 1,
                child: ButtonWidget(
                  onPressed: () {
                    Get.back();
                  },
                  label: AppStrings.yes,
                  backgroundColor: AppColors.primaryBlue,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    const TextWidget(
                      text: AppStrings.details,
                      fontSize: 16,
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
                  return pendingController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          children: [
                            // Header Row
                            Container(
                              color: AppColors.headerColor,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  _buildHeaderCell("Sl", flex: 1),
                                  _buildHeaderCell("Name", flex: 4),
                                  _buildHeaderCell("Qty", flex: 1),
                                  _buildHeaderCell("Unit", flex: 2),
                                ],
                              ),
                            ),
                            // Data Rows (Flatten orders list and pass products only)
                            ..._buildDataRows(
                              pendingController.orders
                                  .expand((datum) => datum.product)
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
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  List<Widget> _buildDataRows(List<Product> products) {
    if (products.isEmpty) {
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

    return products.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

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
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onyxBlack,
                      ),
                    ),
                  ),
                ),
                // Name (Product Name)
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.productId.name ?? "N/A",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onyxBlack,
                      ),
                    ),
                  ),
                ),
                // Quantity
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.productId.quantity.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
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
                      item.productId.unit ?? "N/A",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onyxBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                  child: PopupMenuButton(
                    padding: EdgeInsets.zero,
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
          ));
    }).toList();
  }
}
