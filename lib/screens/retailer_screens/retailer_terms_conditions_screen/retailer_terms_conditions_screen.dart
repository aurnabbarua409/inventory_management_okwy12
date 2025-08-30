import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RetailerTermsConditionsScreen extends StatelessWidget {
  const RetailerTermsConditionsScreen({super.key});

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
        text: AppStrings.termsCondition,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text:
                    "Welcome to ExpressList! By using our platform, you agree to the following terms:",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text: "1. Using ExpressList",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• Retailers: \n    • Provide accurate order details (product, quantity, and unit). \n    • You can adjust quantities or delete items during review but cannot change prices or availability. \n• Wholesalers: \n    • Update availability and pricing accurately before sending orders back to retailers.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "2. Account Responsibility",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• Keep your account information safe. You're responsible for all activity under your account.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "3. Pricing and Payments",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• Wholesalers set final prices; retailers cannot edit them. \n • ExpressList does not process payments. Any disputes must be resolved between users.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "4. Privacy",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• We handle your data as described in our Privacy Policy. By using ExpressList, you agree to our data practices.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "5. Disputes and Liability",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• ExpressList is not responsible for order disputes, delays, or damages caused by users. \n • Resolve disputes directly with your retailer or wholesaler. \n • ExpressList is a platform that facilitates transactions between wholesalers and Retailers. While we strive to provide a secure and reliable environment for business transactions, we cannot guarantee the integrity and legitimacy of all users. Therefore, Users are responsible for conducting due diligence on potential business partners before engaging in any transactions. ExpressList is not liable for any losses or damages arising from dubious or fraudulent transactions.  ",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "6. Suspension",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• We may suspend or terminate accounts for misuse or violating these terms.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
              TextWidget(
                text: "7. Updates",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 2),
              TextWidget(
                text:
                    "• We may update these terms. Continued use of ExpressList means you accept the changes.",
                fontColor: AppColors.onyxBlack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlignment: TextAlign.start,
              ),
              SpaceWidget(spaceHeight: 16),
            ],
          ),
        ),
      ),
    );
  }
}
