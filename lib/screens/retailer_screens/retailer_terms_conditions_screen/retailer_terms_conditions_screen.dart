import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_terms_conditions_screen/controller/term_condition_controller.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RetailerTermsConditionsScreen extends StatefulWidget {
  const RetailerTermsConditionsScreen({super.key});

  @override
  State<RetailerTermsConditionsScreen> createState() =>
      _RetailerTermsConditionsScreenState();
}

class _RetailerTermsConditionsScreenState
    extends State<RetailerTermsConditionsScreen> {
  final _controller = Get.put(TermConditionController());
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
                if (_controller.termConditionData.value.isEmpty) {
                  return const Center(
                    child: TextWidget(
                      text: "Nothing is added yet",
                      fontColor: AppColors.onyxBlack,
                    ),
                  );
                }
                return HtmlWidget(
                  _controller.termConditionData.value,
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
