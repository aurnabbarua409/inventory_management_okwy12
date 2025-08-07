import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerSettingItem extends StatelessWidget {
  const RetailerSettingItem({
    super.key,
    required this.leading, // Allow custom widgets for leading
    required this.title,
    required this.onTap,
  });
  final String leading;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    appLogger("in setting: $title");
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconWidget(
                  height: 24,
                  width: 24,
                  icon: leading,
                  color: AppColors.black,
                ),
                const SpaceWidget(spaceWidth: 20),
                TextWidget(
                  text: title,
                  fontSize: 16,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            if (title != AppStrings.logOut)
              const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
