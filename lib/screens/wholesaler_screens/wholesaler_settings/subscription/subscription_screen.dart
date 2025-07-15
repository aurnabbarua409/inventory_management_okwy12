import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/controller/subs_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/payment_webview_page.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final PaymentController paymentController = Get.put(PaymentController());
    return Scaffold(
      appBar: AppbarWidget(
        text: AppStrings.subscription,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          // Move the SVG and bar to the top
          const SpaceWidget(spaceHeight: 40),
          SvgPicture.asset(
            AppIconsPath.subscription,
            width: 70,
            height: 70,
          ),

          const SpaceWidget(spaceHeight: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 10.0,
              animationDuration: 2000,
              percent: 0.7, // Adjust percentage as needed
              // ignore: deprecated_member_use
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: AppColors.primaryBlue,
              backgroundColor: AppColors.greyLight,
            ),
          ),
          const SpaceWidget(spaceHeight: 16),
          const TextWidget(
            text: "7/10 Orders Used", //$orderNo
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.black,
          ),
          const SpaceWidget(spaceHeight: 25),
          const Center(
            child: TextWidget(
              text: AppStrings.subsplan,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.black,
            ),
          ),
          const SpaceWidget(spaceHeight: 30),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: AppColors.aliceBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColors.primaryBlue),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryBlue,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      TextWidget(
                        text: "Premium",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.black,
                      ),
                    ],
                  ),
                  SpaceWidget(spaceHeight: 8),
                  TextWidget(
                    text: AppStrings.offers,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.greyDark400,
                  ),
                  SpaceWidget(spaceHeight: 12),
                  TextWidget(
                    text: "₦5,000 / Month", //$price
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
          const SpaceWidget(spaceHeight: 30),

          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: ButtonWidget(
              onPressed: () {
                paymentController.createPaymentPackage(); 
                  Get.to(() => const PaymentWebViewPage()); 
              },
              label: AppStrings.subscribe,
              fontSize: 18,
              backgroundColor: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
