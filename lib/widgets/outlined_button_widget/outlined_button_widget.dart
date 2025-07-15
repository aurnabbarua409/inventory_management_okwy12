import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String label;
  final String? icon;
  final double? iconHeight;
  final double? iconWidth;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final double buttonHeight;
  final double buttonWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry buttonRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const OutlinedButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.iconHeight,
    this.iconWidth,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.onPressed,
    this.buttonHeight = 56,
    this.buttonWidth = 200.0,
    this.padding,
    this.buttonRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Container(
      height: ResponsiveUtils.height(buttonHeight),
      width: ResponsiveUtils.width(buttonWidth),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.greyDark200,
        borderRadius: buttonRadius,
        border: Border.all(
          width: ResponsiveUtils.width(1.5),
          color: borderColor ?? AppColors.greyDark200,
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding, // Apply padding
        child: Row(
          mainAxisSize: MainAxisSize.min, // Adjust row size
          children: [
            if (icon != null) ...[
              Image.asset(
                icon!,
                height: ResponsiveUtils.height(iconHeight ?? 24),
                width: ResponsiveUtils.width(iconWidth ?? 24),
              ),
              SizedBox(width: ResponsiveUtils.width(8)), // Spacing between icon and text
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: ResponsiveUtils.width(fontSize),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}