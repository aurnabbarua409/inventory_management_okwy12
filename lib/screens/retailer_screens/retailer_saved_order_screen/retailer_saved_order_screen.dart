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

import '../../../widgets/icon_button_widget/icon_button_widget.dart';

class RetailerSavedOrderScreen extends StatefulWidget {
  const RetailerSavedOrderScreen({super.key});

  @override
  State<RetailerSavedOrderScreen> createState() =>
      _RetailerSavedOrderScreenState();
}

class _RetailerSavedOrderScreenState extends State<RetailerSavedOrderScreen> {
  final controller = Get.put(RetailerSavedOrderScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchOrders();
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
                            controller.clearSelection();
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
                        if (showButtons) ...[
                          // Only show Delete and Send buttons if any checkbox is selected
                          IconButton(
                            onPressed: () async {
                              if (controller.selectedProducts.contains(true)) {
                                controller.showDeleteOrderDialog(
                                  context,
                                );
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
                        // Add Item button in the center when no checkbox is selected
                        if (!showButtons) ...[
                          ButtonWidget(
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
                          InkWell(
                            onTap: () => Get.toNamed(
                                AppRoutes.retailerSavedOrderHistoryScreen),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryBlue, width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: AppColors.primaryBlue,
                                  ),
                                  SpaceWidget(
                                    spaceWidth: 3,
                                  ),
                                  Text(
                                    'Restore List',
                                    style: TextStyle(
                                        color: AppColors.primaryBlue,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]
                      ],
                    );
                  }),
                ),
                // List/Table View
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.fetchOrders();
                      },
                      child: ListView(
                        children: [
                          // Header Row
                          const Text(
                            "Select items to send",
                            textAlign: TextAlign.center,
                          ),
                          const SpaceWidget(
                            spaceHeight: 20,
                          ),
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
                                _buildHeaderCell("Name", flex: 2),
                                _buildHeaderCell("Qty", flex: 1),
                                _buildHeaderCell("Unit", flex: 1),
                                _buildHeaderCell("Action", flex: 1),
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

  List<Widget> _buildDataRows(
    List<GetAllOrderModel> orders,
  ) {
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
              flex: 2,
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
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  controller.productNameController.text =
                      item.productName ?? "";
                  controller.selectedUnit.value = item.unit ?? 'pcs';
                  controller.quantity.value = item.quantity ?? 0;
                  controller.additionalInfoController.text =
                      item.additionalInfo ?? "";
                  controller.showProductEditDialog(context, item.id ?? '-1');
                },
                icon: const Icon(
                  Icons.edit,
                  size: 15,
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
