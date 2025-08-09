import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconWidget(height: 40, width: 40, icon: AppIconsPath.noInternetIcon),
          const TextWidget(
            text:
                "No internet connection.\nPlease check your network and try again.",
            fontColor: AppColors.black,
          ),
          const SpaceWidget(
            spaceHeight: 20,
          ),
          ButtonWidget(
            label: "Refresh",
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    ));
  }
}
