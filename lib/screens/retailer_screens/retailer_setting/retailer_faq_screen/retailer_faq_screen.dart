import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class RetailerFaqScreen extends StatelessWidget {
  const RetailerFaqScreen({super.key});

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
        text: AppStrings.fAq,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "1. How do I create a new order?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text:
                  "• Go to the 'Create New Order' section, add products, quantities, and units, and submit the order to a wholesaler.",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 16),
            TextWidget(
              text:
                  "2. Can I edit an order after submitting it to a wholesaler?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text:
                  "• You can adjust quantities or remove items after the wholesaler sends the order back for review, but prices and availability cannot be changed.",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 16),
            TextWidget(
              text: "3. How do I contact a wholesaler?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text:
                  "• Use the contact details shared by the wholesaler in the order details section.",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 16),
            TextWidget(
              text: "4. What if my wholesaler doesn’t respond?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text:
                  "• You can recall the order and submit it to another wholesaler.",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 16),
            TextWidget(
              text: "5. Is there a fee to use ExpressList?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text: "• The use of ExpressList platform is free for Retailers",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 16),
            TextWidget(
              text:
                  "6. Can I pay my business partner through ExpressList platform?",
              fontColor: AppColors.onyxBlack,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlignment: TextAlign.start,
            ),
            SpaceWidget(spaceHeight: 2),
            TextWidget(
              text:
                  "• NO. ExpressList does not process payments between Wholesalers and Retailers. All payments for goods are made outside the platform",
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
