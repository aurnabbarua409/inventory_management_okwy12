import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_about_us_screen/controller/about_us_controller.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class RetailerAboutUsScreen extends StatefulWidget {
  const RetailerAboutUsScreen({super.key});

  @override
  State<RetailerAboutUsScreen> createState() => _RetailerAboutUsScreenState();
}

class _RetailerAboutUsScreenState extends State<RetailerAboutUsScreen> {
  final _controller = Get.put(AboutUsController());

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
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () {
                if (_controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (_controller.aboutUsData.value.isEmpty) {
                  return const Center(
                    child: TextWidget(
                      text: "Nothing is added yet",
                      fontColor: AppColors.onyxBlack,
                    ),
                  );
                }
                return HtmlWidget(
                  _controller.aboutUsData.value,
                  textStyle: const TextStyle(
                    color: AppColors.onyxBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            )),
      ),
    );
  }
}
