import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/models/new_version/get_pending_order_model.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_received_price_details_history_screen/controller/retailer_received_price_details_controller.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class TableDataRow extends StatefulWidget {
  const TableDataRow(
      {super.key, required this.productsReceived, required this.controller});
  final List<Product> productsReceived;
  final RetailerReceivedOrderDetailsHistoryController controller;

  @override
  State<TableDataRow> createState() => _TableDataRowState();
}

class _TableDataRowState extends State<TableDataRow> {
  List<bool> isEditing = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEditing = List.generate(
      widget.productsReceived.length,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productsReceived.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "No orders available",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          itemCount: widget.productsReceived.length,
          itemBuilder: (context, index) {
            final item = widget.productsReceived[index];
            bool isAvailable = item.availability ?? false;
            int price = item.price ?? 0;
            int quantity = item.quantity ?? 0;
            int total = price * quantity;

            return InkWell(
              onTap: () {
                widget.controller.showProductDetailsDialog(context, item);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300)),
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
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item.productName ?? "N/A",
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
                        child: isEditing[index]
                            ? SizedBox(
                                width: 30,
                                height: 20,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController(
                                      text: item.quantity.toString()),
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
                                        color: isEditing[index]
                                            ? Colors.grey
                                            : Colors.grey,
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
                                    try {
                                      if (value.isEmpty) {
                                        item.quantity = 0;
                                        return;
                                      }
                                      item.quantity = int.parse(value);
                                      quantity = item.quantity ?? 0;
                                      total = quantity * price;
                                      widget.controller.updateGrandTotal();
                                      setState(() {});
                                    } catch (e) {
                                      appLogger(e);
                                    }
                                  },
                                  enabled: isEditing[index],
                                ),
                              )
                            : Text(
                                item.quantity.toString(),
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
                          item.unit ?? "pcs",
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
                          price.toString(),
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
                          total.toString(),
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
                        onSelected: (value) async {
                          if (value == 1) {
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
                            setState(() {
                              isEditing[index] = !isEditing[index];
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text(isEditing[index]
                                ? AppStrings.save
                                : AppStrings.edit),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
