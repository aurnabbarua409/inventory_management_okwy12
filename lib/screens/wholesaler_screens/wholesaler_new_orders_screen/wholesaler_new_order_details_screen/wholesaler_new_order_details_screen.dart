import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/retailer/order_history/retailer_pending_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_images_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../../widgets/image_widget/image_widget.dart';
import '../../../../widgets/outlined_button_widget/outlined_button_widget.dart';
import '../../../../widgets/popup_widget/popup_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/Wholesaler_new_order_details_controller.dart';

class WholesalerNewOrderDetailsScreen extends StatefulWidget {
  const WholesalerNewOrderDetailsScreen({super.key});

  @override
  State<WholesalerNewOrderDetailsScreen> createState() =>
      _WholesalerNewOrderDetailsScreenState();
}

class _WholesalerNewOrderDetailsScreenState
    extends State<WholesalerNewOrderDetailsScreen> {
  final WholesalerNewOrderDetailsController pendingController =
      Get.put(WholesalerNewOrderDetailsController());

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
                child: ListView(
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
                          const SpaceWidget(spaceWidth: 8),
                        ],
                      ),
                    ),
                    // Data Rows
                    ..._buildDataRows(),
                    const SpaceWidget(spaceHeight: 16),

                    ButtonWidget(
                      onPressed: () {
                        pendingController.showSendOrderDialog(context);
                      },
                      label: AppStrings.send,
                      backgroundColor: AppColors.primaryBlue,
                      buttonHeight: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
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
    return pendingController.products.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      // bool isPriceNotZero = item. != 0;
      int price = pendingController.availableList[index].values.first;
      int quantity = item.quantity ?? 0;
      int totalPrice = price * quantity;
      bool available = pendingController.availableList[index].keys.first;

      return GestureDetector(
        onTap: () {
          pendingController.showProductDetailsDialog(context, item);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${index + 1}",
                    // item["sl"]?.toString() ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    item.productName ?? "N/A",
                    // item["name"]?.toString() ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    quantity.toString(),
                    // item["qty"]?.toString() ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item.unit ?? "Kg",
                    // item["unit"]?.toString() ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FlutterSwitch(
                    width: 80,
                    height: 18,
                    toggleSize: 15,
                    borderRadius: 30,
                    padding: 2,
                    value: pendingController.availableList[index].keys.first,
                    onToggle: (bool newValue) {
                      appLogger(
                          "after toggling, isAvailable: $newValue, index: $index");
                      available = newValue;
                      pendingController.availableList
                          .insert(index, {available: price});
                      setState(() {});
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
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: pendingController.availableList[index].keys.first
                    ? SizedBox(
                        height: 30,
                        width: 10,
                        child: TextFormField(
                          initialValue: price.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          enabled: true,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              return;
                            }
                            setState(() {
                              price = int.parse(value);
                              pendingController.availableList
                                  .insert(index, {available: price});

                              totalPrice = (quantity * price);
                            });
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          price.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    totalPrice.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.onyxBlack,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 14,
              //   child: PopupMenuButton(
              //     padding: EdgeInsets.zero,
              //     style: const ButtonStyle(
              //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //       padding: WidgetStatePropertyAll(EdgeInsets.zero),
              //       visualDensity: VisualDensity.compact,
              //     ),
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: AppColors.black,
              //       size: 18,
              //     ),
              //     color: AppColors.white,
              //     onSelected: (value) {
              //       if (value == 1) {
              //         setState(() {
              //           isEditing = !isEditing;
              //         });
              //       }
              //     },
              //     itemBuilder: (context) => [
              //       const PopupMenuItem(
              //         value: 1,
              //         child: Text(AppStrings.edit),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
