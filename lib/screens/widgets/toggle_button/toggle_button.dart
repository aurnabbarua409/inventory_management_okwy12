import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/screens/widgets/toggle_button/toggle_button_controller.dart';
import 'package:inventory_app/utils/app_size.dart';

class ToggleButtonWidget extends StatelessWidget {
  ToggleButtonWidget({super.key, required this.isAvailable});
  

  final ToggleButtonController controller = Get.put(ToggleButtonController());
final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => GestureDetector(
            onTap: controller.toggleSwitch,
            child: Container(
              margin: EdgeInsets.all(ResponsiveUtils.width(5)),
              height: ResponsiveUtils.width(52),
              width: ResponsiveUtils.width(48),
              decoration: BoxDecoration(
                color: controller.isSwitched.value
                    ? AppColors.greenLighter
                    : AppColors.redLighter,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  controller.isSwitched.value ? 'Yes' : 'No',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
