import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RetailerContactUsScreen extends StatelessWidget {
  const RetailerContactUsScreen({super.key});

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
        text: AppStrings.contactUs,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextWidget(
              text: AppStrings.contactUsDesc,
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
