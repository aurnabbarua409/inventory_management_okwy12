import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/build_table_cell_widget.dart';
import 'package:inventory_app/utils/app_size.dart';

class BuildDetailsListWidget extends StatelessWidget {
  const BuildDetailsListWidget(
      {super.key, required this.title, required this.details});
  final String title;
  final List<Map<String, String>> details;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Row
        Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.height(12.0)),
          color: AppColors.tabBG,
          child: Row(
            children: [
              BuildTableCellWidget(title, flex: 1, isHeader: true),
            ],
          ),
        ),
        // Details Rows
        ...details.map((entry) {
          final key = entry.keys.first;
          final value = entry.values.first;
          return Container(
            padding:
                EdgeInsets.symmetric(vertical: ResponsiveUtils.height(12.0)),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.greyLight2)),
            ),
            child: Row(
              children: [
                BuildTableCellWidget("$key:", flex: 2, isHeader: false),
                BuildTableCellWidget(value, flex: 3, isHeader: false),
              ],
            ),
          );
        }),
      ],
    );
  }
}
