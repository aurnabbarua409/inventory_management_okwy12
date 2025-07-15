import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../widgets/icon_widget/icon_widget.dart';
import '../../widgets/space_widget/space_widget.dart';
import '../../widgets/text_widget/text_widgets.dart';

class CustomContainerWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String icon;
  final Color containerColor;
  final String text;

  const CustomContainerWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.containerColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 60,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: IconWidget(
                height: 22,
                width: 22,
                icon: icon,
              ),
            ),
            const SpaceWidget(spaceWidth: 12),
            TextWidget(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.black,
              textAlignment: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
