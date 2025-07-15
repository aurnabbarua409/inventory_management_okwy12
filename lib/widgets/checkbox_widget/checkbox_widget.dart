import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class CheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final Color unselectedColor;
  final double scale;
  final BorderRadiusGeometry borderRadius;

  const CheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColors.primaryBlue,
    this.unselectedColor = AppColors.azureBlue,
    this.scale = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
      child: Transform.scale(
        scale: scale,
        child: SizedBox(
          height: ResponsiveUtils.height(14),
          width: ResponsiveUtils.width(14),
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: unselectedColor,
            ),
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: activeColor,
              checkColor: AppColors.white,
              value: value,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: WidgetStateBorderSide.resolveWith(
                  (states) =>
                      const BorderSide(width: 0.5, color: AppColors.azureBlue),
                ),
              ),
              side: const BorderSide(
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
