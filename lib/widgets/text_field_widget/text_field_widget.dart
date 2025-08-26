import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons_path.dart';
import '../../utils/app_size.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines; // Add maxLines as a parameter
  final VoidCallback? onTapSuffix;
  final bool obscureText;
  final String? preffixIcon;
  final String? suffixIcon2;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged; // Added onChanged parameter

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.suffixIcon2,
    this.obscureText = false,
    this.preffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.onTapSuffix,
    this.autofillHints,
    this.onChanged, // Initialize onChanged in constructor
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize obscureText based on suffixIcon being a password toggle
    obscureText = (widget.suffixIcon == AppIconsPath.visibleOffIcon) ||
        (widget.suffixIcon2 == AppIconsPath.speakerIcon);
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autofillHints: widget.autofillHints ?? [],
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        style: const TextStyle(
          color: AppColors.black,
        ),
        onChanged: widget.onChanged, // Set the onChanged callback
        decoration: InputDecoration(
          fillColor: AppColors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w300,
            fontSize: ResponsiveUtils.width(14),
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Padding(
                    padding: obscureText
                        ? const EdgeInsets.all(8)
                        : const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      obscureText
                          ? AppIconsPath.visibleOffIcon
                          : AppIconsPath.visibleIcon,
                      height: ResponsiveUtils.width(20),
                      width: ResponsiveUtils.width(20),
                    ),
                  ),
                )
              : null,
          prefixIcon: widget.preffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppIconsPath.addCard,
                      height: ResponsiveUtils.width(20),
                      width: ResponsiveUtils.width(20),
                    ),
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
        ),
      ),
    );
  }
}
