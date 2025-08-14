import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/auth_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'controller/forgot_password_screen_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordScreenController controller =
      Get.put(ForgotPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: ResponsiveUtils.width(28)),
          const AuthAppbarWidget(text: AppStrings.forgetPw),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceWidget(spaceHeight: 36),
                  const Center(
                    child: TextWidget(
                      text: AppStrings.forgetPwDesc,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.black,
                    ),
                  ),
                  const SpaceWidget(spaceHeight: 36),
                  const TextWidget(
                    text: AppStrings.emailPhoneNumber,
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
                        return 'Please Enter a Email Address';
                      }
                      const pattern =
                          r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                      final regex = RegExp(pattern);

                      if (value.isNotEmpty && !regex.hasMatch(value)) {
                        return 'Enter a Valid Email Address';
                      }
                      return null;
                    },
                  ),
                  const SpaceWidget(spaceHeight: 48),
                  ButtonWidget(
                    onPressed: () {
                      controller.forgotPassword();
                    },
                    label: AppStrings.continueText,
                    backgroundColor: AppColors.primaryBlue,
                    buttonWidth: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
