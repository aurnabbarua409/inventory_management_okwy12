import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class NormalTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final String? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines;
  final VoidCallback? onTapSuffix;
  final bool obscureText;
  final String? preffixIcon;

  const NormalTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.preffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.onTapSuffix,
  });

  @override
  State<NormalTextFieldWidget> createState() => _NormalTextFieldWidgetState();
}

class _NormalTextFieldWidgetState extends State<NormalTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        style: const TextStyle(
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          fillColor: AppColors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w300,
            fontSize: ResponsiveUtils.width(14),
          ),
          // Update: GestureDetector to prevent keyboard trigger
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    // Prevent TextField from gaining focus
                    FocusScope.of(context).unfocus();
                    // Trigger voice recognition
                    if (widget.onTapSuffix != null) {
                      widget.onTapSuffix!();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      widget.suffixIcon!,
                      height: ResponsiveUtils.width(20),
                      width: ResponsiveUtils.width(20),
                    ),
                  ),
                )
              : null,
          prefixIcon: widget.preffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    widget.preffixIcon!,
                    height: ResponsiveUtils.width(20),
                    width: ResponsiveUtils.width(20),
                  ),
                )
              : null,
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
        ),
      ),
    );
  }
}
