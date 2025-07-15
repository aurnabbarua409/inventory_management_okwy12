import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/wholesaler_new_order_controller.dart';

class WholesalerPendingOrderDetailsScreen extends StatefulWidget {
  const WholesalerPendingOrderDetailsScreen({super.key});

  @override
  State<WholesalerPendingOrderDetailsScreen> createState() =>
      _WholesalerPendingOrderDetailsScreenState();
}

class _WholesalerPendingOrderDetailsScreenState
    extends State<WholesalerPendingOrderDetailsScreen> {
  final WholesalerPendingOrderDetailController pendingController =
      Get.put(WholesalerPendingOrderDetailController());

  // Function to show the send order dialog
  void showSendOrderDialog(BuildContext context) {
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
            text: AppStrings.wholesalerAreYouSureDesc,
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
                    showSendOrderSuccessfulDialog(context);
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

  // Function to show the successful order sent dialog
  void showSendOrderSuccessfulDialog(BuildContext context) {
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
          child: ImageWidget(
            height: 64,
            width: 64,
            imagePath: AppImagesPath.checkImage,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        const Center(
          child: TextWidget(
            text: AppStrings.wholesalerOrderSentSuccessfully,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.wholesalerOrderSentSuccessfullyDesc,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.onyxBlack,
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
                  return ListView(
                    children: [
                      // Header Row
                      Container(
                        color: AppColors.headerColor,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            _buildHeaderCell("Sl", flex: 0),
                            _buildHeaderCell("Product", flex: 2),
                            _buildHeaderCell("Qty", flex: 1),
                            _buildHeaderCell("Unit", flex: 1),
                            _buildHeaderCell("Avail", flex: 1),
                            _buildHeaderCell("Price", flex: 1),
                            _buildHeaderCell("Total", flex: 1),
                          ],
                        ),
                      ),
                      // Data Rows
                      ..._buildDataRows(),
                      const SpaceWidget(spaceHeight: 16),
                      ButtonWidget(
                        onPressed: () {
                          // Show dialog to send order (implement functionality)
                        },
                        label: AppStrings.send,
                        backgroundColor: AppColors.primaryBlue,
                        buttonHeight: 45,
                        fontWeight: FontWeight.w500,
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDataRows() {
    return pendingController.orders.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            // Sl Number
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item.id.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
            // Product Name
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  item.product[0].productId.name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
            // Quantity
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() {
                  return Text(
                    item.product[0].productId.quantity.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  );
                }),
              ),
            ),
            // Unit
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item.product[0].productId.unit,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
            // Availability Switch
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Obx(() {
                  return FlutterSwitch(
                    width: 80,
                    height: 18,
                    toggleSize: 15,
                    borderRadius: 30,
                    padding: 2,
                    value: item.product[0].availability,
                    onToggle: (bool newValue) {
                      pendingController.updateProductData(
                          index, 0, availability: newValue);
                    },
                    activeColor: Colors.green,
                    inactiveColor: AppColors.red,
                    inactiveToggleColor: Colors.white,
                    showOnOff: true,
                    valueFontSize: 8,
                    activeText: "Yes",
                    inactiveText: "No",
                    activeTextFontWeight: FontWeight.w600,
                    inactiveTextFontWeight: FontWeight.w600,
                    activeTextColor: AppColors.white,
                    inactiveTextColor: AppColors.white,
                  );
                }),
              ),
            ),
            // Price
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() {
                  return Text(
                    item.product[0].price.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  );
                }),
              ),
            ),
            // Total
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() {
                  return Text(
                    item.product[0].total.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
