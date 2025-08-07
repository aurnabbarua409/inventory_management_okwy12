import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/retailer_find_wholeseller_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_home_screen/retailer_home_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/retailer_order_history_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_setting/retailer_settings_screen/retailer_settings_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_home_screen/wholesaler_home_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/wholesaler_order_history.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_settings_screen/wholesaler_settings.dart';
import 'package:inventory_app/utils/app_enum.dart';
import 'package:inventory_app/utils/app_logger.dart';

class BottomNavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  late UserRole userRole;
  List<Widget> widgetOptions = [];
  void changeIndex(int value) {
    selectedIndex.value = value;
    appLogger(selectedIndex.value);
    update();
  }

  final List<Widget> navItemsRetailer = [
    const RetailerHomeScreen(),
    const RetailerFindWholeSellerScreen(),
    RetailerOrderHistoryScreen(),
    const RetailerSettingsScreen(),
  ];
  final List<Widget> navItemWholesaler = [
    const WholesalerHomeScreen(),
    const WholesalerOrderHistoryScreen(
      initialTabIndex: 0,
      key: ValueKey("tab1"),
    ),
    const WholesalerOrderHistoryScreen(
      initialTabIndex: 1,
      key: ValueKey("tab2"),
    ),
    const WholesalerSettings(),
  ];
  // List<Widget> widgetOptions = userRole == UserRole.retailer
  //     ? [
  //         const RetailerHomeScreen(),
  //         RetailerFindWholeSellerScreen(),
  //         const RetailerOrderHistoryScreen(),
  //         const RetailerSettingsScreen(),
  //       ]
  //     : [
  //         const WholesalerHomeScreen(),
  //         // RetailerOrderHistoryScreen(),
  //         // RetailerOrderHistoryScreen(),
  //         // WholesalerOrderHistoryScreen(),
  //         // WholesalerOrderHistoryScreen(),
  //         const WholesalerOrderHistoryScreen(
  //           initialTabIndex: 0,
  //           key: ValueKey("tab1"),
  //         ),
  //         const WholesalerOrderHistoryScreen(
  //           initialTabIndex: 1,
  //           key: ValueKey("tab2"),
  //         ),
  //         const WholesalerSettings(),
  //       ];

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
    widgetOptions =
        userRole == UserRole.retailer ? navItemsRetailer : navItemWholesaler;
  }
}
