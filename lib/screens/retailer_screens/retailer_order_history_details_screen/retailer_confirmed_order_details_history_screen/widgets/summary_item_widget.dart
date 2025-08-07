import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:pdf/widgets.dart' as pw;

class SummaryItemWidget extends StatelessWidget {
  const SummaryItemWidget(
      {super.key, required this.title, required this.price});
  final String title;

  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SpaceWidget(
          spaceWidth: 5,
        ),
        const ImageWidget(
          imagePath: AppImagesPath.currencyIcon,
          width: 11,
          height: 11,
        ),
        Text(
          price.toStringAsFixed(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
