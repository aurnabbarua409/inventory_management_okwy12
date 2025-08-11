import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/controller/retailer_confirmed_order_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/build_table_cell_widget.dart';
import 'package:inventory_app/utils/app_size.dart';

class BuildInvoiceTableWidget extends StatelessWidget {
  const BuildInvoiceTableWidget({super.key, required this.confirmedController});
  final ConfirmedOrderDetailsHistoryController confirmedController;
  @override
  Widget build(BuildContext context) {
    final invoiceItems = confirmedController.confirmedData.value != null
        ? confirmedController.confirmedData.value!.product
            ?.map((product) => {
                  "product": product.productName,
                  "qty": product.quantity.toString(),
                  "unit": product.unit,
                  "price": product.price.toString(),
                  "total": ((product.price ?? 0) * (product.quantity ?? 0)).toString(),
                })
            .toList()
        : [];

    confirmedController.totalPrice.value =
        0; // Reset totalAmount before calculation

    return Column(
      children: [
        // Table Header
        Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.width(12.0)),
          color: AppColors.tabBG,
          child: const Row(
            children: [
              BuildTableCellWidget("SI", flex: 1, isHeader: true),
              BuildTableCellWidget("Product", flex: 2, isHeader: true),
              BuildTableCellWidget("Qty", flex: 1, isHeader: true),
              BuildTableCellWidget("Unit", flex: 1, isHeader: true),
              BuildTableCellWidget("Price", flex: 1, isHeader: true),
              BuildTableCellWidget("Total", flex: 1, isHeader: true),
            ],
          ),
        ),
        // Table Rows
        ...invoiceItems!.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          confirmedController.totalPrice.value +=
              double.tryParse(item["total"] ?? "0") ?? 0;
          return Container(
            padding:
                EdgeInsets.symmetric(vertical: ResponsiveUtils.width(12.0)),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.greyLight2)),
            ),
            child: Row(
              children: [
                BuildTableCellWidget(index.toString(), flex: 1),
                BuildTableCellWidget(item["product"] ?? "", flex: 2),
                BuildTableCellWidget(item["qty"] ?? "", flex: 1),
                BuildTableCellWidget(item["unit"] ?? "", flex: 1),
                BuildTableCellWidget(item["price"] ?? "", flex: 1),
                BuildTableCellWidget(item["total"] ?? "", flex: 1),
              ],
            ),
          );
        }),
      ],
    );
  }
}
