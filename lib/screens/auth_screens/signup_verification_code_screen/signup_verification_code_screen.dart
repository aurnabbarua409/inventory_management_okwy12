import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/auth_screens/forgot_password_verification_code_screen/widgets/otp_field_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/auth_appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import 'controller/signup_verification_code_screen_controller.dart';

class SignupVerificationCodeScreen extends StatelessWidget {
  SignupVerificationCodeScreen({super.key});

  final SignupVerifyCodeScreenController controller =
      Get.put(SignupVerifyCodeScreenController());
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    //final userRole = arguments['userRole'];
    final email = arguments['email'];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthAppbarWidget(text: AppStrings.enterVerificationCode),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpaceWidget(spaceHeight: 36),
                    Center(
                      child: TextWidget(
                        text: AppStrings.sentACode + email,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.black,
                      ),
                    ),
                    const SpaceWidget(spaceHeight: 36),
                    const TextWidget(
                      text: AppStrings.code,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.black,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController1),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController2),
                            OtpInputFieldWidget(
                                controller:
                                    controller.otpTextEditingController3),
                            OtpInputFieldWidget(
                              controller: controller.otpTextEditingController4,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (p0) {
                                FocusManager.instance.primaryFocus?.unfocus(
                                    disposition: UnfocusDisposition
                                        .previouslyFocusedChild);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SpaceWidget(spaceHeight: 8),
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 8),
                        ),
                        child: TextWidget(
                          text: controller.canResend.value
                              ? AppStrings.remainingTime
                              : "${AppStrings.resendCodeIn} ${controller.formatTime()}",
                          fontColor: controller.canResend.value
                              ? AppColors.onyxBlack
                              : AppColors.onyxBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }),
                    const SpaceWidget(spaceHeight: 32),
                    ButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ??
                            false) {
                          controller.verifyOTP();
                        } else {
                          Get.snackbar(
                            "Invalid Input",
                            "Please enter the complete verification code.",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      label: AppStrings.continueText,
                      buttonWidth: double.infinity,
                      backgroundColor: AppColors.primaryBlue,
                    ),
                    const SpaceWidget(spaceHeight: 12),
                    Obx(() {
                      if (controller.canResend.value) {}
                      return controller.canResend.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const TextWidget(
                                    text: AppStrings.didntReceiveOtp,
                                    fontColor: AppColors.onyxBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                  ),
                                  const SpaceWidget(spaceWidth: 8),
                                  TextButtonWidget(
                                    onPressed: () {
                                      controller.resendCode();
                                    },
                                    text: AppStrings.resendOtp,
                                    textColor: AppColors.primaryBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
