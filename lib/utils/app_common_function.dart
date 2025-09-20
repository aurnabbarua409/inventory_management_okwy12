import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/outlined_button_widget/outlined_button_widget.dart';
import 'package:inventory_app/widgets/popup_widget/popup_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AppCommonFunction {
  static final List<String> units = [
    'Pcs',
    'Cup',
    'Unit',
    'Roll',
    'Crate',
    'Bottle',
    'Carton',
    'Gal',
    'Bag',
    'Pkt',
    'Dozen',
    'Kg',
    'Other',
  ];
  static String? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Email';
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
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
  }

  static String? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 4) {
      return "Password should be atleast 4 character";
    }
    return null;
  }

  static void invite() async {
    try {
      final response = await ApiService.getApi(Urls.inviteLink);
      appLogger(response);
      if (response != null) {
        final data = response['data'] as List;
        final url = data[0]['link'];
        Share.share(
          url,
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch invite link');
      }
    } catch (e) {
      appLogger(e);
    }
  }

  static Future<File> getAssetAsFile(String assetPath) async {
    // Load asset as byte data
    final byteData = await rootBundle.load(assetPath);

    // Get temp directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    // Write asset bytes to the file
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  static void showDeleteOrderDialog(
      BuildContext context, void Function() ondelete) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: TextWidget(
            text: AppStrings.areYouSure,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.deleteProductDesc,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButtonWidget(
                  onPressed: () {
                    Get.back();
                  },
                  label: AppStrings.no,
                  backgroundColor: AppColors.white,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  textColor: AppColors.primaryBlue,
                  borderColor: AppColors.primaryBlue,
                  fontSize: 14,
                ),
              ),
              const SpaceWidget(spaceWidth: 16),
              Expanded(
                flex: 1,
                child: ButtonWidget(
                  onPressed: () {
                    ondelete();
                    Get.back();
                  },
                  label: AppStrings.yes,
                  backgroundColor: AppColors.primaryBlue,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }
}
