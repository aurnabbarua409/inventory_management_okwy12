import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_all_order_model.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_saved_order_screen/controller/retailer_saved_order_screen_controller.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../../constants/app_images_path.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/outlined_button_widget/outlined_button_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';

class RetailerSavedOrderScreen extends StatelessWidget {
  RetailerSavedOrderScreen({super.key});

  final controller = Get.put(RetailerSavedOrderScreenController());

  void showDeleteOrderDialog(BuildContext context, String orderId) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () => Get.back(),
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
            text: AppStrings.deleteDesc,
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
                  onPressed: () => Get.back(),
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
                    controller.deleteRow(orderId);
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

  void showDeleteOrderSuccessfulDialog(BuildContext context) {
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
            text: AppStrings.deleteSuccessfulDesc,
            fontSize: 14,
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        } else {
          return Center(
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
                          text: AppStrings.orderSaved,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    // Show Delete/Send Buttons when any checkbox is selected, else show Add Item button
                    bool showButtons =
                        controller.selectedProducts.contains(true) ||
                            controller.selectAll.value;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (showButtons) // Only show Delete and Send buttons if any checkbox is selected
                          Row(
                            children: [
                              // Delete Button on the left
                              IconButton(
                                onPressed: () async {
                                  if (controller.selectedProducts
                                      .contains(true)) {
                                    List<String> selectedOrderIds = [];
                                    for (int i = 0;
                                        i < controller.selectedProducts.length;
                                        i++) {
                                      if (controller.selectedProducts[i]) {
                                        selectedOrderIds
                                            .add(controller.orders[i].id!);
                                      }
                                    }

                                    if (selectedOrderIds.isNotEmpty) {
                                      for (String id in selectedOrderIds) {
                                        await controller.deleteRow(id);
                                      }
                                    }
                                  } else {
                                    Get.snackbar('No Selection',
                                        'Please select an order to delete');
                                  }
                                },
                                icon: const IconWidget(
                                  height: 38,
                                  width: 28,
                                  icon: AppIconsPath.delete,
                                ),
                              ),

                              // Send Button on the right
                              ButtonWidget(
                                onPressed: controller.shareSelection,
                                label: 'Send',
                                fontWeight: FontWeight.w500,
                                backgroundColor: AppColors.primaryBlue,
                                buttonWidth: 80,
                                buttonHeight: 40,
                              ),
                            ],
                          ),

                        // Add Item button in the center when no checkbox is selected
                        if (!showButtons)
                          Center(
                            child: ButtonWidget(
                              onPressed: () {
                                Get.toNamed(
                                    AppRoutes.retailerCreateNewOrderScreen);
                              },
                              label: 'Add New Item',
                              fontWeight: FontWeight.w500,
                              backgroundColor: AppColors.primaryBlue,
                              buttonWidth: 175,
                              buttonHeight: 40,
                              icon: Icons.add,
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                // List/Table View
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RefreshIndicator(
                      onRefresh: controller.fetchOrders,
                      child: ListView(
                        children: [
                          // Header Row
                          Container(
                            color: AppColors.headerColor,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Obx(() => Transform.scale(
                                      scale: 0.8,
                                      child: Checkbox(
                                        value: controller.selectAll.value,
                                        onChanged: (bool? value) {
                                          controller.toggleSelectAll(value!);
                                        },
                                      ),
                                    )),
                                _buildHeaderCell("Name", flex: 3),
                                _buildHeaderCell("Qty", flex: 1),
                                _buildHeaderCell("Unit", flex: 1),
                              ],
                            ),
                          ),
                          // Data Rows
                          ..._buildDataRows(controller.orders),
                        ],
                      ),
                    ),
                  ),
                ),
                // const BottomNavBar()
              ],
            ),
          );
        }
      }),
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

  List<Widget> _buildDataRows(List<GetAllOrderModel> orders) {
    if (orders.isEmpty) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "No order created",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ];
    }

    return orders.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Obx(() => index < controller.selectedProducts.length
                ? Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: controller.selectedProducts[index],
                      onChanged: (bool? value) {
                        controller.toggleCheckbox(index);
                      },
                    ),
                  )
                : SizedBox()), // Prevents index out of range
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.productName ?? "N/A",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.quantity.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.unit ?? "Pcs",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.onyxBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
