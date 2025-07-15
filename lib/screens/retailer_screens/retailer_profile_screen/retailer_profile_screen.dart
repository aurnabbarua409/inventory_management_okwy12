import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_profile_screen/controller/retailer_profile_screen_controller.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerProfileScreen extends StatelessWidget {
  const RetailerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppbarWidget(
        text: AppStrings.profile,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder(
        init: ProfileScreenController(),
        builder: (controller) =>  SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveUtils.height(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceWidget(spaceHeight: 16),
              Center(
                child: GestureDetector(
                  onTap: () => controller.showImageSourceDialog(context),
                  child: CircleAvatar(
                    radius: ResponsiveUtils.width(50),
                    backgroundColor: Colors.grey[300],
                    child: Obx(() {
                      // Use the observable 'image' to update the profile image
                      if (controller.image.value.isNotEmpty) {
                        return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  controller.image
                                      .value, // Use controller.image.value here
                                  fit: BoxFit.cover,
                                  height: ResponsiveUtils.width(100),
                                  width: ResponsiveUtils.width(100),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return ClipOval(
                                      child: Image.asset(
                                          'assets/default_image.png',
                                          fit: BoxFit.cover), // Fallback image
                                    );
                                  },
                                ),
                              ),
                              Icon(
                                Icons.camera_alt,
                                size: ResponsiveUtils.width(25),
                                color: AppColors.blueDarker,
                              )
                            ]);
                      } else {
                        return Icon(
                          Icons.camera_alt,
                          size: ResponsiveUtils.width(30),
                          color: AppColors.oceanBlue,
                        );
                      }
                    }),
                  ),
                ),
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.fullName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.fullNameController,
                hintText: AppStrings.nameHint,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.businessName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.businessNameController,
                hintText: AppStrings.businesshint,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business name';
                  }
                  return null;
                },
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.email,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.emailController,
                hintText: AppStrings.emailhint,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.phoneNumber,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.phoneController,
                hintText: AppStrings.hintnumber,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SpaceWidget(spaceHeight: 16),
              const TextWidget(
                text: AppStrings.address,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SpaceWidget(spaceHeight: 12),
              TextFieldWidget(
                controller: controller.addressController,
                hintText: AppStrings.hintAddress,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SpaceWidget(spaceHeight: 36),
              ButtonWidget(
                onPressed: () {
                  controller.updateProfileRepo();
                },
                label: AppStrings.updatePassword,
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
