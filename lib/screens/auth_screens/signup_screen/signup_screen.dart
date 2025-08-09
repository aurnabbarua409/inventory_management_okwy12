import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_enum.dart';
import 'package:inventory_app/widgets/appbar_widget/auth_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/international_phone_field_widget/international_phone_field_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_button_widget/text_button_widget.dart';
import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'controller/signup_screen_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupScreenController controller = Get.put(SignupScreenController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthAppbarWidget(text: AppStrings.signup),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpaceWidget(spaceHeight: 24),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButtonWidget(
                              onPressed: () {
                                controller.selectedRole.value = UserRole
                                    .retailer; // Set the selected role to retailer
                              },
                              label: AppStrings.retailer,
                              textColor: controller.selectedRole.value ==
                                      UserRole.retailer
                                  ? AppColors
                                      .white // Change text color when selected
                                  : AppColors.black,
                              backgroundColor: controller.selectedRole.value ==
                                      UserRole.retailer
                                  ? AppColors
                                      .primaryBlue // Set background color to primaryBlue when selected
                                  : Colors
                                      .white, // Initially white background when not selected
                              borderColor: AppColors.primaryBlue,
                            ),
                          ),
                          const SpaceWidget(spaceWidth: 16),
                          Expanded(
                            child: OutlinedButtonWidget(
                              onPressed: () {
                                controller.selectedRole.value = UserRole
                                    .wholesaler; // Set the selected role to wholesaler
                              },
                              label: AppStrings.wholesaler,
                              textColor: controller.selectedRole.value ==
                                      UserRole.wholesaler
                                  ? AppColors
                                      .white // Change text color when selected
                                  : AppColors.black,
                              backgroundColor: controller.selectedRole.value ==
                                      UserRole.wholesaler
                                  ? AppColors
                                      .primaryBlue // Set background color to primaryBlue when selected
                                  : Colors
                                      .white, // Initially white background when not selected
                              borderColor: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Obx(
                      () {
                        if (controller.selectedRole.value != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: AppStrings.fullName,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              TextFieldWidget(
                                controller: controller.nameController,
                                hintText: AppStrings.enterYourName,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              const TextWidget(
                                text: AppStrings.email,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              TextFieldWidget(
                                controller: controller.emailController,
                                hintText: AppStrings.enterYourEmailAddress,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              const TextWidget(
                                text: AppStrings.password,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              TextFieldWidget(
                                controller: controller.passwordController,
                                hintText: AppStrings.enterPassword,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                suffixIcon: AppIconsPath.visibleOffIcon,
                              ),
                              const SizedBox(height: 16),
                              const TextWidget(
                                text: AppStrings.confirmPassword,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              TextFieldWidget(
                                controller:
                                    controller.confirmPasswordController,
                                hintText: AppStrings.enterPassword,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  return null;
                                },
                                suffixIcon: AppIconsPath.visibleOffIcon,
                              ),
                              const SizedBox(height: 16),
                              const TextWidget(
                                text: AppStrings.phoneNumber,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.black,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              InternationalPhoneFieldWidget(
                                onInputChanged: (p0) {
                                  controller.phoneNumber.value =
                                      p0.phoneNumber!;
                                },
                                onInputValidated: (p0) {
                                  controller.isValidPhonenumber.value = p0;
                                },
                              ),
                              // const SpaceWidget(spaceHeight: 12),
                              // TextFieldWidget(
                              //   controller: controller.phoneNumberController,
                              //   hintText: 'Enter your phone number',
                              //   maxLines: 1,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter your phone number';
                              //     }
                              //     if (value.length != 11) {
                              //       return "Phone number should be atleast 11 character";
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const SpaceWidget(spaceHeight: 24),
                              ButtonWidget(
                                onPressed: () {
                                  if (controller.selectedRole.value == null) {
                                    Get.snackbar('Error',
                                        'Please select your role (Retailer/Wholesaler)',
                                        snackPosition: SnackPosition.BOTTOM);
                                    return;
                                  }
                                  if (_formKey.currentState == null ||
                                      !_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  controller.handleContinue();
                                },
                                label: AppStrings.continueText,
                                backgroundColor: AppColors.primaryBlue,
                                buttonWidth: double.infinity,
                              ),
                              const SpaceWidget(spaceHeight: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const TextWidget(
                                    text: AppStrings.alreadyHaveAccount,
                                    fontColor: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SpaceWidget(spaceWidth: 4),
                                  TextButtonWidget(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.signinScreen);
                                    },
                                    text: AppStrings.signIn,
                                    textColor: AppColors.primaryBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        // Return an empty SizedBox when no role is selected
                        return const SizedBox.shrink();
                      },
                    ),
                    const SpaceWidget(spaceHeight: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
