import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    for (var product in widget.productsReceived) {
      product.textEditingController = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    for (var product in widget.productsReceived) {
      product.textEditingController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLogger(isEditing);
    if (widget.productsReceived.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "No orders available. Please go back and refresh",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Form(
        key: widget.controller.formKey,
        child: ListView.builder(
            itemCount: widget.productsReceived.length,
            itemBuilder: (context, index) {
              final item = widget.productsReceived[index];
              bool isAvailable = item.availability ?? false;
              num price = item.price ?? 0.0;
              int quantity = item.quantity ?? 0;
              num total = price * quantity;

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
                          padding: const EdgeInsets.only(left: 8),
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
                      // Quantity
                      Expanded(
                        flex: 1,
                        child: isEditing[index]
                            ? Container(
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: TextFormField(
                                  controller: item.textEditingController,
                                  // initialValue: quantity.toString(),
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  // controller: TextEditingController(
                                  //     text: item.quantity.toString()),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 0),
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
                                    errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.red)),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.red)),
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

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ' ';
                                    }
                                    final parsedValue = int.tryParse(value);
                                    if (parsedValue == null ||
                                        parsedValue <= 0) {
                                      return ' ';
                                    }
                                    if (parsedValue >
                                        widget.controller.prevQuantity[index]) {
                                      return ' ';
                                    }
                                    return null;
                                  },
                                  // onChanged: (value) {
                                  //   try {
                                  //     if (value.isEmpty) {
                                  //       item.quantity = 0;
                                  //       return;
                                  //     }

                                  //     quantity = int.parse(value);
                                  //     item.quantity = quantity;
                                  //     total = quantity * price;
                                  //     widget.controller.updateGrandTotal();

                                  //     // setState(() {});
                                  //   } catch (e) {
                                  //     appLogger(e);
                                  //   }
                                  // },
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
                      // Unit
                      Expanded(
                        flex: 1,
                        child: Text(
                          item.unit ?? "pcs",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                        ),
                      ),

                      // Availability
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
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
                        child: Text(
                          price.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                        ),
                      ),
                      // Total
                      Expanded(
                        flex: 1,
                        child: Text(
                          total.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.onyxBlack,
                          ),
                        ),
                      ),

                      // More Options
                      Expanded(
                        flex: 0,
                        child: isAvailable
                            ? PopupMenuButton(
                                padding: EdgeInsets.zero,
                                style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
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
                                    setState(() {
                                      isEditing[index] = !isEditing[index];
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
                                    if (widget.controller.formKey.currentState!
                                        .validate()) {
                                      try {
                                        quantity = int.parse(
                                            item.textEditingController!.text);
                                        item.quantity = quantity;
                                        total = quantity * price;
                                        widget.controller.updateGrandTotal();

                                        setState(() {});
                                      } catch (e) {
                                        appLogger(e);
                                      }
                                    } else {
                                      item.quantity =
                                          widget.controller.prevQuantity[index];
                                      Get.snackbar("Error",
                                          'You can not increase the quantity more than wholesaler approved, if you want additional quantity send new order');
                                    }
                                  }
                                  if (value == 2) {
                                    final url = Urls.deleteProduct + item.id!;
                                    final response =
                                        await ApiService.deleteApi(url, {});
                                    appLogger(response);
                                    widget.productsReceived
                                        .removeWhere((id) => item.id == id.id);

                                    setState(() {});
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text(isEditing[index]
                                        ? AppStrings.save
                                        : AppStrings.decrease),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text(AppStrings.delete),
                                  ),
                                ],
                              )
                            : const SizedBox(
                                width: 32,
                                height: 40,
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
