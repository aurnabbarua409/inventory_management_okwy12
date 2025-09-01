import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_contact_us_screen/controller/contact_us_controller.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class RetailerContactUsScreen extends StatefulWidget {
  const RetailerContactUsScreen({super.key});

  @override
  State<RetailerContactUsScreen> createState() =>
      _RetailerContactUsScreenState();
}

class _RetailerContactUsScreenState extends State<RetailerContactUsScreen> {
  final _controller = Get.put(ContactUsController());
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
                if (_controller.contactUsData.value.isEmpty) {
                  return const Center(
                    child: TextWidget(
                      text: "Nothing is added yet",
                      fontColor: AppColors.onyxBlack,
                    ),
                  );
                }
                return HtmlWidget(
                  _controller.contactUsData.value,
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
