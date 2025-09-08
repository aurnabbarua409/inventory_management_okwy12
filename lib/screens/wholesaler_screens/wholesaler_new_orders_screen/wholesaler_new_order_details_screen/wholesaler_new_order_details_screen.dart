import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/main_appbar_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
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
                    const Spacer(),
                    const TextWidget(
                      text: AppStrings.details,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.white,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SpaceWidget(spaceHeight: 16),

            // List/Table View
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Obx(
                    () => ListView(
                      children: [
                        // Header Row
                        Container(
                          color: AppColors.headerColor,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              _buildHeaderCell("Sl",
                                  flex: 0, spaceHorizontal: 8),
                              _buildHeaderCell("Product", flex: 2),
                              _buildHeaderCell("Qty", flex: 1),
                              _buildHeaderCell(
                                "Unit",
                                flex: 1,
                              ),
                              _buildHeaderCell("Avail", flex: 1),
                              _buildHeaderCell("Price", flex: 1),
                              _buildHeaderCell("Total", flex: 1),
                              _buildHeaderCell("", flex: 1),
                              // const SpaceWidget(spaceWidth: 10),
                            ],
                          ),
                        ),
                        // Data Rows
                        // WholesalerNewOrderRows(controller: pendingController),
                        ..._buildDataRows(),
                        const SpaceWidget(spaceHeight: 16),

                        SafeArea(
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonWidget(
                                  onPressed: () {
                                    pendingController.onSave;
                                  },
                                  label: AppStrings.save,
                                  backgroundColor: AppColors.primaryBlue,
                                  buttonHeight: 45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SpaceWidget(
                                spaceWidth: 10,
                              ),
                              Expanded(
                                child: ButtonWidget(
                                  onPressed: () {
                                    appLogger(pendingController.isEditing);
                                    if (pendingController.isEditing.any(
                                        (isEditing) => isEditing == true)) {
                                      Get.snackbar(
                                        'Hold on!',
                                        'You have unsaved changes. Please save them before confirming.',
                                        snackPosition: SnackPosition.TOP,
                                      );

                                      return;
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      pendingController
                                          .showSendOrderDialog(context);
                                    } else {
                                      Get.snackbar('Error',
                                          'Please enter a valid price');
                                    }
                                  },
                                  label: AppStrings.send,
                                  backgroundColor: AppColors.primaryBlue,
                                  buttonHeight: 45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text,
      {int flex = 1, double spaceHorizontal = 0, double spaceVertical = 10}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: spaceHorizontal, vertical: spaceVertical),
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
      num price = item.price ?? 0.0;
      int quantity = item.quantity ?? 0;
      num totalPrice = price * quantity;
      bool available = item.availability ?? false;

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
                    disabled: !pendingController.isEditing[index],
                    width: 80,
                    height: 18,
                    toggleSize: 15,
                    borderRadius: 30,
                    padding: 2,
                    value: item.availability ?? false,
                    onToggle: (bool newValue) {
                      appLogger(
                          "after toggling, isAvailable: $newValue, index: $index");
                      available = newValue;
                      price = 0;
                      pendingController.products[index].price = 0;
                      pendingController.products[index].availability = newValue;
                      setState(() {});
                      if (newValue) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          pendingController.products[index].focusNode
                              ?.requestFocus();
                        });
                      }
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
                child: (item.availability ?? false) &&
                        (pendingController.isEditing[index])
                    ? SizedBox(
                        height: 30,
                        width: 10,
                        child: TextFormField(
                          initialValue: price == 0 ? "" : price.toString(),
                          keyboardType: TextInputType.number,
                          focusNode: item.focusNode,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(fontSize: 0),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          enabled: true,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            final parsedValue = double.tryParse(value);
                            if (parsedValue == null || parsedValue <= 0) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            try {
                              if (value.isEmpty) {
                                return;
                              }

                              setState(() {
                                price = double.parse(value);

                                pendingController.products[index].price = price;

                                totalPrice = (quantity * price);
                              });
                            } catch (e) {
                              appLogger(e);
                            }
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
              Expanded(
                flex: 0,
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
                  onSelected: (value) async {
                    if (value == 1) {
                      appLogger("after changing the price: ${price}");
                      // totalPrice = price * quantity;
                      appLogger("total price is: $totalPrice");
                      setState(() {
                        pendingController.isEditing[index] =
                            !pendingController.isEditing[index];
                      });

                      // if (isEditing[index]) {
                      //   try {
                      //     final url =
                      //         "${Urls.updateReceivedOrder}${item.id}";
                      //     final response = await ApiService.patchApi(url,
                      //         {"quantity": item.quantity ?? 0});
                      //     appLogger(response);
                      //   } catch (e) {
                      //     appLogger(e);
                      //   }
                      // }
                      if (_formKey.currentState!.validate()) {
                        try {
                          price = int.parse(item.textEditingController!.text);
                          item.price = price;

                          setState(() {});
                        } catch (e) {
                          appLogger(e);
                        }
                      } else {
                        item.price = 0;
                        Get.snackbar("Error", 'Invalid price');
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(pendingController.isEditing[index]
                          ? AppStrings.save
                          : AppStrings.edit),
                    ),
                  ],
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
