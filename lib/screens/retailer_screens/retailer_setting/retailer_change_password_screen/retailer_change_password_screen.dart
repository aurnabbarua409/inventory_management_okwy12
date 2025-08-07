import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_change_password_screen/controller/change_password_controller.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerChangePasswordScreen extends StatelessWidget {
  RetailerChangePasswordScreen({super.key});

  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: AppStrings.changePassword,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const TextWidget(
                text: AppStrings.currentPassword,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.currentPasswordController,
                hintText: 'Enter password',
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
                text: AppStrings.newPassword,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.newPasswordController,
                hintText: 'Enter password',
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
                suffixIcon: AppIconsPath.visibleOffIcon,
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.confirmNewPassword,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.confirmNewPasswordController,
                hintText: 'Enter password',
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please  your password';
                  }
                  if (controller.newPasswordController.text != value) {
                    return 'Password mismatched';
                  }
                  return null;
                },
                suffixIcon: AppIconsPath.visibleOffIcon,
              ),
              const SpaceWidget(spaceHeight: 36),
              ButtonWidget(
                onPressed: () {
                  controller.resetPassword();
                },
                label: AppStrings.update,
                backgroundColor: AppColors.primaryBlue,
                buttonWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
