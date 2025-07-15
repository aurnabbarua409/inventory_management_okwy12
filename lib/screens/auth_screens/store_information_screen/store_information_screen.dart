import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_button_widget/text_button_widget.dart';
import 'package:inventory_app/widgets/checkbox_widget/checkbox_widget.dart';
import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
import 'package:inventory_app/widgets/appbar_widget/auth_appbar_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'controller/store_information_screen_controller.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
//import '../../../routes/app_routes.dart';

class StoreInformationScreen extends StatelessWidget {
  StoreInformationScreen({super.key});

  final StoreInformationScreenController controller =
      Get.put(StoreInformationScreenController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //final arguments = Get.arguments;
    //final userRole = arguments['userRole'];
    //final email = arguments['email'];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthAppbarWidget(text: AppStrings.storeInformation),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpaceWidget(spaceHeight: 24),
                    const TextWidget(
                      text: AppStrings.businessName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.black,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    TextFieldWidget(
                      controller: controller.businessNameController,
                      hintText: 'Enter business Name',
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter business name';
                        }
                        return null;
                      },
                    ),
                    const SpaceWidget(spaceHeight: 26),
                    const TextWidget(
                      text: AppStrings.businessCategory,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.black,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    Obx(() {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: const Text(
                            'Select Category',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                          value: controller.selectedBusinessCategory.value,
                          items: controller.categories
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            controller.setSelectedBusinessCategory(value);
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            height: 61,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.strokeColor,
                                width: 1,
                              ),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                    const SpaceWidget(spaceHeight: 24),
                    const TextWidget(
                      text: AppStrings.storeAddress,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.black,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    TextFieldWidget(
                      controller: controller.storeAddressController,
                      hintText: 'Add your full address (street, city, state)',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full address (street, city, state)';
                        }
                        return null;
                      },
                    ),
                    const SpaceWidget(spaceHeight: 4),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 2,
                      runSpacing: -8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Obx(() {
                          return CheckboxWidget(
                            value: controller.isChecked.value,
                            onChanged: controller.toggleCheckbox,
                            activeColor: AppColors.primaryBlue,
                            unselectedColor: Colors.grey,
                          );
                        }),
                        const SpaceWidget(spaceWidth: 4),
                        const TextWidget(
                          text: AppStrings.iAgreeTo,
                          fontColor: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        TextButtonWidget(
                          onPressed: () {},
                          text: AppStrings.termsCondition,
                          textColor: AppColors.primaryBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        const TextWidget(
                          text: AppStrings.andThe,
                          fontColor: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        TextButtonWidget(
                          onPressed: () {},
                          text: AppStrings.privacyPolicy,
                          textColor: AppColors.primaryBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SpaceWidget(spaceHeight: 40),
                    ButtonWidget(
                      onPressed: () {
                        if (!(_formKey.currentState!.validate())) {
                          return;
                        }
                        controller.continueToNextScreen();
                      },
                      label: AppStrings.continueText,
                      backgroundColor: AppColors.primaryBlue,
                      buttonWidth: double.infinity,
                    ),
                    const SpaceWidget(spaceHeight: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
