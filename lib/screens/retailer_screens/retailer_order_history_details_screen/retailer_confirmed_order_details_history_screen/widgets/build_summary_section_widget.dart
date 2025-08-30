import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/controller/retailer_confirmed_order_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/summary_item_widget.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

class BuildSummarySectionWidget extends StatelessWidget {
  const BuildSummarySectionWidget(this.confirmedController, {super.key});
  final ConfirmedOrderDetailsHistoryController confirmedController;
  @override
  Widget build(BuildContext context) {
    final double grandTotal = confirmedController.totalPrice.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceWidget(
          spaceHeight: 10,
        ),
        // SummaryItemWidget(title: AppStrings.subTotal, price: grandTotal),
        SummaryItemWidget(
            title: AppStrings.grandTotal,
            price: confirmedController.formatPrice(grandTotal)),
        SizedBox(height: ResponsiveUtils.height(24)),
        // Download Button
        SafeArea(
          child: ButtonWidget(
            onPressed: () {
              confirmedController.generatePdf();
            },
            label: AppStrings.invoiceDownload,
            backgroundColor: AppColors.primaryBlue,
            buttonWidth: double.infinity,
          ),
        ),
      ],
    );
  }
}
