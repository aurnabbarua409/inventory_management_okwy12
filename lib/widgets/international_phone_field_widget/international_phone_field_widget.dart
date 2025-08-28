import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class InternationalPhoneFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final PhoneNumber? initialValue; 
  final Function(PhoneNumber) onInputChanged;
  final Function(bool)? onInputValidated;

  const InternationalPhoneFieldWidget({
    super.key,
    this.controller,
    required this.initialValue,
    required this.onInputChanged,
    this.onInputValidated,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onInputChanged,
        onInputValidated: onInputValidated,
        textFieldController: controller,
        initialValue: initialValue,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.all(ResponsiveUtils.width(14)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.strokeColor,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.extremelyRed,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.extremelyRed,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          hintText: "Enter phone number",
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w300,
            fontSize: ResponsiveUtils.width(14),
          ),
        ),
        selectorTextStyle: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        inputBorder: InputBorder.none,
        formatInput: true,
        autoFocus: false,
      ),
    );
  }
}
