import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/controller/subs_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/payment_webview_page.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_profile_screen/controller/wholesaler_profile_screen_controller.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  var isSubscribed;
  var totalOrders;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final control = Get.find<WholesalerProfileScreenController>();
    control.fetchProfile();
    isSubscribed = PrefsHelper.isSubscribed;
    totalOrders = PrefsHelper.totalOrders;
    appLogger("$isSubscribed subscribe, total order: $totalOrders");
  }

  @override
  Widget build(BuildContext context) {
    // final PaymentController paymentController = Get.put(PaymentController());
    // var isSubscribed = PrefsHelper.isSubscribed;
    // var totalOrders = PrefsHelper.totalOrders;
    appLogger("$isSubscribed subscribe, total order: $totalOrders");
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
        // action: IconButton(
        //     onPressed: () async {
        //       final control = Get.find<WholesalerProfileScreenController>();
        //       await control.fetchProfile();
        //       isSubscribed = PrefsHelper.isSubscribed;
        //       totalOrders = PrefsHelper.totalOrders;
        //       appLogger("$isSubscribed subscribe, total order: $totalOrders");
        //       setState(() {});
        //     },
        //     icon: const Icon(Icons.refresh)),
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
          !isSubscribed
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 10.0,
                        animationDuration: 2000,
                        percent: totalOrders > 50
                            ? 1
                            : totalOrders / 50, // Adjust percentage as needed
                        // ignore: deprecated_member_use
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: AppColors.primaryBlue,
                        backgroundColor: AppColors.greyLight,
                      ),
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    TextWidget(
                      text: "$totalOrders/50 Orders Used", //$orderNo
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
                            Row(
                              children: [
                                ImageWidget(
                                    height: 14,
                                    width: 14,
                                    imagePath: AppImagesPath.currencyIcon),
                                TextWidget(
                                  text: "5,000 / Month", //$price
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontColor: AppColors.black,
                                ),
                              ],
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
                          final control = Get.put(PaymentController());
                          control.createPaymentPackage();
                          Get.to(() => PaymentWebViewPage(
                                controller: control,
                              ));
                        },
                        label: AppStrings.subscribe,
                        fontSize: 18,
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: ButtonWidget(
                        onPressed: () {},
                        label: 'You\'re a Premium Member!',
                        fontSize: 18,
                        backgroundColor: AppColors.primaryBlue,
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
                                  text: "Premium Active",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontColor: AppColors.black,
                                ),
                              ],
                            ),
                            SpaceWidget(spaceHeight: 8),
                            TextWidget(
                              text: 'No limits on your order',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: AppColors.greyDark400,
                            ),
                            SpaceWidget(spaceHeight: 12),
                            Row(
                              children: [
                                ImageWidget(
                                    height: 14,
                                    width: 14,
                                    imagePath: AppImagesPath.currencyIcon),
                                TextWidget(
                                  text: "5,000 / Month", //$price
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontColor: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
