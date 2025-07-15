import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_size.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? action;
  final Color? appbarColor;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final Widget? leading; // Make leading optional

  const AppbarWidget({
    super.key,
    required this.text,
    this.action,
    this.appbarColor,
    this.bottom,
    this.centerTitle,
    this.leading, // Add leading to constructor
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: Container(color: appbarColor ?? AppColors.white),
      titleSpacing: 1,
      leading: leading,
      actions: action != null ? [action!] : null,
      title: Text(
        text,
        style: TextStyle(
          fontSize: ResponsiveUtils.width(18),
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
