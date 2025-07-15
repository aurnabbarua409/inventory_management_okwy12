import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final Function(String) onChanged;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
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
        onChanged: widget.onChanged, // Call the provided onChanged callback
        decoration: InputDecoration(
          fillColor: AppColors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.greyDark200,
            fontWeight: FontWeight.w300,
            fontSize: ResponsiveUtils.width(14),
          ),
          contentPadding: EdgeInsets.all(ResponsiveUtils.width(18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.greyLight,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.greyLight,
              width: ResponsiveUtils.width(0.75),
            ),
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                    });
                    widget.onChanged("");
                  },
                )
              : null,
        ),
      ),
    );
  }
}