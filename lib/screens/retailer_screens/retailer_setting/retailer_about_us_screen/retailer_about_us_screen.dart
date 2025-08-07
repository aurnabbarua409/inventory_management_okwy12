import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class RetailerAboutUsScreen extends StatelessWidget {
  const RetailerAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: AppbarWidget(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        text: AppStrings.aboutUs,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                TextWidget(
                  text: AppStrings.aboutUsIntro,
                  fontColor: AppColors.onyxBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                TextWidget(
                  text: AppStrings.appName,
                  fontColor: AppColors.onyxBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            TextWidget(
              text: AppStrings.aboutUsDesc,
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
