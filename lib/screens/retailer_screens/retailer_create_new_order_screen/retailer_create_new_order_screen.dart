import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_create_new_order_screen/controller/retailer_create_new_order_controller.dart';
import 'package:inventory_app/screens/widgets/item_counter_button.dart';
import 'package:inventory_app/utils/app_common_function.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/normal_text_field_widget/normal_text_field_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerCreateNewOrderScreen extends StatelessWidget {
  RetailerCreateNewOrderScreen({super.key});

  final RetailerCreateNewOrderScreenController controller =
      Get.put(RetailerCreateNewOrderScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else {
            return Column(
              children: [
                MainAppbarWidget(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButtonWidget(
                          onTap: () {
                            Get.back();
                          },
                          icon: AppIconsPath.backIcon,
                          color: AppColors.white,
                          size: 22,
                        ),
                        const TextWidget(
                          text: AppStrings.createNewOrder,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.white,
                        ),
                        const SpaceWidget(spaceWidth: 28),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        elevation: 3,
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: AppStrings.productName,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 10),
                              NormalTextFieldWidget(
                                controller: controller.productNameController,
                                hintText: AppStrings.enterProductname,
                                maxLines: 1,
                                suffixIcon: AppIconsPath.voiceIcon,
                                onTapSuffix: () {
                                  controller.startVoiceRecognition(true);
                                },
                              ),
                              const SpaceWidget(spaceHeight: 14),
                              const TextWidget(
                                text: AppStrings.unit,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 10),
                              Obx(() {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select unit',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    value: controller.selectedUnit.isNotEmpty
                                        ? controller.selectedUnit.value
                                        : null,
                                    items: AppCommonFunction.units.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      controller.setSelectedUnit(value);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 14),
                                      height: 52,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.strokeColor,
                                          width: 0.75,
                                        ),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              const SpaceWidget(spaceHeight: 14),
                              const TextWidget(
                                text: AppStrings.quantity2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 10),
                              Row(
                                children: [
                                  ItemCount(
                                    initialValue: controller.quantity.value,
                                    minValue: 1,
                                    onChanged: (value) =>
                                        controller.quantity.value = value,
                                  ),
                                ],
                              ),
                              const SpaceWidget(spaceHeight: 14),
                              const TextWidget(
                                text: AppStrings.additionalInfo,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 10),
                              NormalTextFieldWidget(
                                controller: controller.additionalInfoController,
                                hintText:
                                    'Add any instructions for your wholesaler',
                                maxLines: 4,
                                suffixIcon: AppIconsPath.voiceIcon,
                                onTapSuffix: () {
                                  controller.startVoiceRecognition(false);
                                },
                              ),
                              const SpaceWidget(spaceHeight: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: OutlinedButtonWidget(
                                      onPressed: () async {
                                        controller.createItem();
                                        // Check if order is NOT null (success)
                                        //Get.toNamed(
                                        // AppRoutes.retailerSavedOrderScreen,
                                        // arguments: order);
                                        // Get.lazyPut(() =>
                                        //     RetailerSavedOrderScreenController());
                                        // Get.to(
                                        //   () => RetailerSavedOrderScreen(),
                                        // );
                                      },
                                      label: AppStrings.save,
                                      backgroundColor: AppColors.primaryBlue,
                                      buttonWidth: 100,
                                      buttonHeight: 50,
                                      textColor: AppColors.white,
                                      borderColor: AppColors.primaryBlue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SpaceWidget(spaceHeight: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
