import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/auth_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Bar
            const AuthAppbarWidget(),
            const SizedBox(height: 52),
            // Onboarding Title
            const TextWidget(
              text: AppStrings.onboardingTitle,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontColor: AppColors.primaryBlue,
              textAlignment: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description Text
            TextWidget(
              text: AppStrings.onboardingDesc,
              fontSize: ResponsiveUtils.width(14),
              fontWeight: FontWeight.w500,
              fontColor: AppColors.black,
              textAlignment: TextAlign.center,
            ),
            const SizedBox(height: 72),

            // Login Button
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(30)),
              child: ButtonWidget(
                onPressed: () {
                  Get.toNamed(AppRoutes.signinScreen);
                },
                label: AppStrings.login,
                buttonWidth: double.infinity,
                backgroundColor: AppColors.primaryBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Space between buttons

            // Create Account Button
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(30)),
              child: ButtonWidget(
                onPressed: () {
                  Get.toNamed(AppRoutes.signupScreen);
                },
                label: AppStrings.createAnAccount,
                textColor: AppColors.primaryBlue,
                buttonWidth: double.infinity,
                backgroundColor: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
