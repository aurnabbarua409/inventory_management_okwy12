import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/widgets/toggle_button/toggle_button.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class WholesalerOrder extends StatelessWidget {
  const WholesalerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context); // Initialize screen dimensions

    final tableHeaders = [
      "SI",
      "Product",
      "Qty",
      "Unit",
      "Available",
      "Price",
      "Total"
    ];
    final tableRows = [
      // {
      //   "product": "Rice",
      //   "qty": "2",
      //   "unit": "Rolls",
      //   "available": true,
      //   "price": "₦100",
      //   "total": "₦300",
      // },
      // {
      //   "product": "Coca-Cola 300ml",
      //   "qty": "12",
      //   "unit": "Crates",
      //   "available": true,
      //   "price": "₦100",
      //   "total": "₦300",
      // },
      // {
      //   "product": "Maple Syrup 220ml",
      //   "qty": "2",
      //   "unit": "Trucks",
      //   "available": true,
      //   "price": "₦100",
      //   "total": "₦300",
      // },
      // {
      //   "product": "Rice",
      //   "qty": "3",
      //   "unit": "Kg",
      //   "available": false,
      //   "price": "₦0",
      //   "total": "₦0",
      // },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          MainAppbarWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: ResponsiveUtils.width(28)),
                const TextWidget(
                  text: AppStrings.newOrder,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    isLabelVisible: true,
                    label: Text("2"),
                    backgroundColor: AppColors.extremelyRed,
                    child: IconWidget(
                      height: 24,
                      width: 24,
                      icon: AppIconsPath.notificationIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.width(16)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Table
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ResponsiveUtils.width(8))),
                      child: Column(
                        children: [
                          // Table Header
                          Container(
                            color: const Color(0xFFE3F2FD),
                            child: Row(
                              children: tableHeaders.map((header) {
                                return _buildTableCell(
                                  header,
                                  isHeader: true,
                                  flex: header == AppStrings.product ? 1 : 1,
                                );
                              }).toList(),
                            ),
                          ),
                          // Table Rows
                          ...tableRows.asMap().entries.map((entry) {
                            final index = entry.key + 1;
                            final row = entry.value;
                            return Row(
                              children: [
                                _buildTableCell(
                                  index.toString(),
                                  flex: 1,
                                ),
                                _buildTableCell(
                                  row[AppStrings.product] as String? ?? "",
                                  flex: 3,
                                ),
                                _buildTableCell(
                                  row[AppStrings.quantity2] as String? ?? "",
                                  flex: 1,
                                ),
                                _buildTableCell(
                                  row[AppStrings.unit] as String? ?? "",
                                  flex: 1,
                                ),
                                _buildTableCell(
                                  "",
                                  flex: 1,
                                  child: ToggleButtonWidget(
                                    isAvailable:
                                        (row[AppStrings.available] as bool?) ??
                                            false,
                                  ),
                                ),
                                _buildTableCell(
                                  row[AppStrings.price] as String? ?? "",
                                  flex: 1,
                                ),
                                _buildTableCell(
                                  row[AppStrings.total] as String? ?? "",
                                  flex: 1,
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.height(16)),
                    // Update Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle update action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.width(32),
                          vertical: ResponsiveUtils.height(12),
                        ),
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text,
      {int flex = 1, bool isHeader = false, Widget? child}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.width(8),
          vertical: ResponsiveUtils.height(12),
        ),
        child: child ??
            Text(
              text,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: isHeader
                    ? ResponsiveUtils.height(10)
                    : ResponsiveUtils.height(8),
                color: isHeader ? Colors.black : Colors.grey[800],
              ),
              textAlign: isHeader ? TextAlign.center : TextAlign.left,
            ),
      ),
    );
  }
}
