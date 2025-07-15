import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';
import '../space_widget/space_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;
  final double buttonHeight;
  final double buttonWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry buttonRadius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;  // Added boxShadow to allow shadow customization

  const ButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.onPressed,
    this.buttonHeight = 56,
    this.buttonWidth = 200.0,
    this.padding,
    this.buttonRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor,
    this.boxShadow,  // Pass boxShadow as a parameter
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
        boxShadow: boxShadow,  // Apply the shadow effect here
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: ResponsiveUtils.width(fontSize),
                fontWeight: fontWeight,
              ),
            ),
            if (icon != null) const SpaceWidget(spaceWidth: 12),
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? textColor,
                size: iconSize ?? ResponsiveUtils.width(fontSize),
              ),
          ],
        ),
      ),
    );
  }
}
