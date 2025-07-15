import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/utils/app_size.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/auth_appbar_widget.dart';
import '../../../widgets/button_widget/button_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
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
                    hintText: 'Enter your email address',
                    maxLines: 1,
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
