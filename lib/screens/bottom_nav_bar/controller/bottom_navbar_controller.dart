import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/utils/app_enum.dart';
import 'package:inventory_app/utils/app_logger.dart';

class BottomNavbarController extends GetxController {
 

  final RxInt selectedIndex = 0.obs;
  late UserRole userRole;

  void changeIndex(int value) {
    selectedIndex.value = value;
    appLogger(selectedIndex.value);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments;
    // Retrieve the user role from the passed arguments
    String userRoleString = arguments['userRole'] ??
        'retailer'; // Default to 'retailer' if not found
    userRole = UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == userRoleString.toLowerCase(),
      orElse: () =>
          UserRole.retailer, // Default to retailer if the role is unknown
    );
  }
}
