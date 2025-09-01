import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_faq_screen/controller/retailer_faq_controller.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class RetailerFaqScreen extends StatefulWidget {
  const RetailerFaqScreen({super.key});

  @override
  State<RetailerFaqScreen> createState() => _RetailerFaqScreenState();
}

class _RetailerFaqScreenState extends State<RetailerFaqScreen> {
  final _controller = Get.put(RetailerFaqController());
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
      body: SafeArea(
        child: Obx(
          () {
            if (_controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (_controller.faqData.isEmpty) {
              return const Center(
                child: TextWidget(
                  text: "Nothing is added yet",
                  fontColor: AppColors.onyxBlack,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: _controller.faqData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "${index + 1}. ",
                                fontColor: AppColors.onyxBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              Expanded(
                                child: HtmlWidget(
                                  _controller.faqData[index].question,
                                  textStyle: const TextStyle(
                                    color: AppColors.onyxBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: "• ",
                                fontColor: AppColors.onyxBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              Expanded(
                                child: HtmlWidget(
                                  _controller.faqData[index].answer,
                                  textStyle: const TextStyle(
                                    color: AppColors.onyxBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
