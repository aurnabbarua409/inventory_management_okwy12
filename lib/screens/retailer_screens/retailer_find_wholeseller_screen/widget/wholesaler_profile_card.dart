// WholesalerProfileCard widget:
import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:inventory_app/models/retailer/find_wholesaler/get_wholesaler_model.dart';

class WholesalerProfileCard extends StatelessWidget {
  final WholeSalerDetails wholesaler;
  final VoidCallback onTap;
  final bool isSelected;
  final ValueChanged<bool> onLongPress;
  final ValueChanged<bool> onDoubleTap;

  const WholesalerProfileCard({
    super.key,
    required this.wholesaler,
    required this.onTap,
    required this.isSelected,
    required this.onLongPress,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    print(
        "Wholesaler Card: ${wholesaler.storeInformation.businessName}, isSelected: $isSelected");
    return GestureDetector(
      onLongPress: () => onLongPress(!isSelected),
      onDoubleTap: () => onDoubleTap(false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: AppColors.greyLight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ImageWidget(
                    height: 82,
                    width: 82,
                    imagePath: isSelected
                        ? AppImagesPath.checkImage
                        : AppImagesPath.wholesalerProfileImage,
                  ),
                ),
                const SpaceWidget(spaceWidth: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(AppIconsPath.buildingIcon,
                        wholesaler.storeInformation.businessName),
                    const SpaceWidget(spaceHeight: 6),
                    _buildInfoRow(AppIconsPath.telephoneIcon, wholesaler.email),
                    const SpaceWidget(spaceHeight: 6),
                    _buildInfoRow(AppIconsPath.mailIcon, wholesaler.email,
                        width: 170),
                    const SpaceWidget(spaceHeight: 6),
                    _buildInfoRow(AppIconsPath.locationIcon,
                        wholesaler.storeInformation.location,
                        width: 170, maxLines: 2),
                  ],
                ),
              ],
            ),
            const SpaceWidget(spaceHeight: 16),
            if (!isSelected) // Hide button if selected
              ButtonWidget(
                onPressed: onTap,
                label: AppStrings.sendOrder,
                backgroundColor: AppColors.primaryBlue,
                buttonWidth: double.infinity,
                buttonHeight: 40,
                fontSize: 14,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String icon, String text,
      {double width = double.infinity, int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconWidget(height: 14, width: 14, icon: icon),
        const SpaceWidget(spaceWidth: 8),
        TextWidget(
          text: text,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.onyxBlack,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
