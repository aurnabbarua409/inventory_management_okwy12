import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: AppStrings.noData,
            fontSize: 16,
          )
        ],
      ),
    );
  }
}
