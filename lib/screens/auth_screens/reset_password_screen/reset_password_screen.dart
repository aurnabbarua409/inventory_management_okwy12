import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/auth_appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/resent_password_screen_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPasswordScreenController controller =
      Get.put(ResetPasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthAppbarWidget(text: AppStrings.resetYourPassword),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceWidget(spaceHeight: 36),
                  const TextWidget(
                    text: AppStrings.setNewPassword,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.black,
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  TextFieldWidget(
                    controller: controller.newPasswordController,
                    hintText: 'Enter password',
                    maxLines: 1,
                    suffixIcon: AppIconsPath.visibleOffIcon,
                  ),
                  const SpaceWidget(spaceHeight: 24),
                  const TextWidget(
                    text: AppStrings.confirmPassword,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.black,
                  ),
                  const SpaceWidget(spaceHeight: 12),
                  TextFieldWidget(
                    controller: controller.confirmPasswordController,
                    hintText: 'Enter password',
                    maxLines: 1,
                    suffixIcon: AppIconsPath.visibleOffIcon,
                  ),
                  const SpaceWidget(spaceHeight: 40),
                  ButtonWidget(
                    onPressed: () {
                      controller.resetPassword();
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
