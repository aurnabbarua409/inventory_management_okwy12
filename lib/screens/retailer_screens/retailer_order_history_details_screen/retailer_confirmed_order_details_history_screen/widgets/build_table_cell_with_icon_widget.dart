import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';

class BuildTableCellWithIconWidget extends StatelessWidget {
  const BuildTableCellWithIconWidget(this.text, {super.key, this.flex = 1});
  final String text;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(8.0)),
        child: Row(
          children: [
            const ImageWidget(
              imagePath: AppImagesPath.currencyIcon,
              width: 11,
              height: 11,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            // const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
