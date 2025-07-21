import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
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
  const WholesalerNewOrderDetailsScreen({super.key, required this.id, required this.product});
  final String id;
  final List product;
  @override
  State<WholesalerNewOrderDetailsScreen> createState() =>
      _WholesalerNewOrderDetailsScreenState();
}

class _WholesalerNewOrderDetailsScreenState
    extends State<WholesalerNewOrderDetailsScreen> {
  final WholesalerNewOrderDetailsController pendingController =
      Get.put(WholesalerNewOrderDetailsController());
  bool isEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pendingController.fetchOrderDatails(widget.id);
  }

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

  // Data moved to class level
  final List<Map<String, dynamic>> data = [
    {
      "sl": "01",
      "name": "Rice",
      "qty": "3",
      "unit": "Kg",
      "available": false,
      "price": "100",
      "total": "300",
    },
    {
      "sl": "02",
      "name": "Samsung Galaxy S22",
      "qty": "15",
      "unit": "Pcs",
      "available": false,
      "price": "100",
      "total": "1500",
    },
    {
      "sl": "03",
      "name": "Coca Cola 300ml",
      "qty": "5",
      "unit": "Bottle",
      "available": false,
      "price": "0",
      "total": "0",
    },
  ];

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
                        showSendOrderDialog(context);
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
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      bool isPriceNotZero = item["price"] != "0";

      return Container(
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
                  item["sl"]?.toString() ?? "",
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
                  item["name"]?.toString() ?? "",
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
                  item["qty"]?.toString() ?? "",
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
                  item["unit"]?.toString() ?? "",
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
                  value: item["available"] as bool,
                  onToggle: (bool newValue) {
                    setState(() {
                      data[index]["available"] = newValue;
                      if (!newValue) {
                        data[index]["price"] = "0";
                        data[index]["total"] = "0";
                      }
                    });
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
              child: item["available"] as bool
                  ? SizedBox(
                      height: 30,
                      width: 10,
                      child: TextFormField(
                        initialValue: item["price"]?.toString() ?? "",
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
                          setState(() {
                            data[index]["price"] = value;
                            int qty =
                                int.tryParse(data[index]["qty"] as String) ?? 0;
                            int price = int.tryParse(value) ?? 0;
                            data[index]["total"] = (qty * price).toString();
                          });
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        item["price"]?.toString() ?? "",
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
                  item["total"]?.toString() ?? "",
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
      );
    }).toList();
  }
}
