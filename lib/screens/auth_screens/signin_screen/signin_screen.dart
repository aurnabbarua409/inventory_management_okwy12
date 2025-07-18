import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/auth_screens/signin_screen/controller/signin_screen_controller.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/auth_appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final SignInScreenController controller = Get.put(SignInScreenController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthAppbarWidget(text: AppStrings.signInToYourAccount),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      hintText: 'Enter your email or phone number',
                      maxLines: 1,
                    ),
                    const SpaceWidget(spaceHeight: 24),
                    const TextWidget(
                      text: AppStrings.password,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.black,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    TextFieldWidget(
                      controller: controller.passwordController,
                      hintText: 'Enter password',
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return "Password should be atleast 6 character";
                        }
                        return null;
                      },
                      suffixIcon: AppIconsPath.visibleOffIcon,
                    ),
                    const SpaceWidget(spaceHeight: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButtonWidget(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPasswordScreen);
                        },
                        text: AppStrings.forgotPw,
                        textColor: AppColors.primaryBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SpaceWidget(spaceHeight: 24),
                    ButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState == null ||
                            !(_formKey.currentState!.validate())) {
                          return;
                        }
                        controller.signInUser();
                      },
                      label: AppStrings.signIn,
                      backgroundColor: AppColors.primaryBlue,
                      buttonWidth: double.infinity,
                    ),
                    const SpaceWidget(spaceHeight: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWidget(
                          text: AppStrings.dontHaveAccount,
                          fontColor: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        const SpaceWidget(spaceWidth: 4),
                        TextButtonWidget(
                          onPressed: () {
                            Get.toNamed(AppRoutes.signupScreen);
                          },
                          text: AppStrings.signup,
                          textColor: AppColors.primaryBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
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
