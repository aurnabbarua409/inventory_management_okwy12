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
        ? confirmedController.product
            .map((product) => {
                  "product": product.productName,
                  "qty": product.quantity.toString(),
                  "unit": product.unit,
                  "price": product.price.toString(),
                  "total": ((product.price ?? 0) * (product.quantity ?? 0))
                      .toString(),
                })
            .toList()
        : [];

    confirmedController.totalPrice.value =
        0; // Reset totalAmount before calculation

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(AppColors.tabBG),
        columns: const [
          DataColumn(
            label: Center(child: Text("SI")),
            numeric: false,
          ),
          DataColumn(
            label: Center(child: Text("Product")),
            numeric: false,
          ),
          DataColumn(
            label: Center(child: Text("Quantity")),
            numeric: false,
          ),
          DataColumn(
            label: Center(child: Text("Unit")),
            numeric: false,
          ),
          DataColumn(
            label: Center(child: Text("Price")),
            numeric: false,
          ),
          DataColumn(
            label: Center(child: Text("Total")),
            numeric: false,
          ),
        ],
        rows: invoiceItems.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          confirmedController.totalPrice.value +=
              double.tryParse(item["total"] ?? "0") ?? 0;
          return DataRow(
            cells: [
              DataCell(Center(child: Text(index.toString()))),
              DataCell(Center(child: Text(item["product"] ?? ""))),
              DataCell(Center(child: Text(item["qty"] ?? ""))),
              DataCell(Center(child: Text(item["unit"] ?? ""))),
              DataCell(Center(child: Text(item["price"] ?? ""))),
              DataCell(Center(child: Text(item["total"] ?? ""))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
