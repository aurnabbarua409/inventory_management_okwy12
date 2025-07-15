import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../widgets/image_widget/image_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class AuthAppbarWidget extends StatelessWidget {
   final String? text ;

  const AuthAppbarWidget({ this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImagesPath.splashBg),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const ImageWidget(
            height: 170,
            width: 170,
            imagePath: AppImagesPath.appLogo,
          ),
          TextWidget(
            text: text,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
