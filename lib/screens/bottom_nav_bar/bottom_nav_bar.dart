import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_home_screen/retailer_home_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/retailer_order_history_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_settings_screen/retailer_settings_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_home_screen/wholesaler_home_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/wholesaler_order_history.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_settings.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons_path.dart';
import '../../utils/app_enum.dart';
import '../retailer_screens/retailer_find_wholeseller_screen/retailer_find_wholeseller_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavbarController(),
        builder: (controller) {
          // Define which set of screens to show based on the user role
          final List<Widget> widgetOptions =
              controller.userRole == UserRole.retailer
                  ? [
                      const RetailerHomeScreen(),
                      RetailerFindWholeSellerScreen(),
                      const RetailerOrderHistoryScreen(),
                      const RetailerSettingsScreen(),
                    ]
                  : [
                      const WholesalerHomeScreen(),
                      // RetailerOrderHistoryScreen(),
                      // RetailerOrderHistoryScreen(),
                      // WholesalerOrderHistoryScreen(),
                      // WholesalerOrderHistoryScreen(),
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

          return Scaffold(         
            backgroundColor: AppColors.white,
            body: Center(
                child: widgetOptions.elementAt(controller.selectedIndex.value)),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: AppColors.primaryBlue,
                    backgroundColor: AppColors.white,
                    textStyle: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    tabBorderRadius: 16,
                    tabs: [
                      GButton(
                        leading: SizedBox(
                          width: 25,
                          height: 25,
                          child: Obx(
                            () => SvgPicture.asset(
                              AppIconsPath.homeIcon,
                              color: controller.selectedIndex.value == 0
                                  ? AppColors.white
                                  : AppColors.onyxBlack,
                            ),
                          ),
                        ),
                        icon: Icons.home,
                      ),
                      GButton(
                        icon: Icons.home,
                        leading: SizedBox(
                          width: 26,
                          height: 26,
                          child: Obx(
                            () => SvgPicture.asset(
                              AppIconsPath.wholeSellerListIcon,
                              color: controller.selectedIndex.value == 1
                                  ? AppColors.white
                                  : AppColors.onyxBlack,
                            ),
                          ),
                        ),
                      ),
                      GButton(
                        icon: Icons.home,
                        leading: SizedBox(
                          width: 25,
                          height: 25,
                          child: Obx(
                            () => SvgPicture.asset(
                              AppIconsPath.orderIcon,
                              color: controller.selectedIndex.value == 2
                                  ? AppColors.white
                                  : AppColors.onyxBlack,
                            ),
                          ),
                        ),
                        // leading: Badge(
                        //   // isLabelVisible: true,
                        //   // label: const Text("3"),
                        //  // backgroundColor: AppColors.extremelyRed,
                        //   child: SizedBox(
                        //     width: 25,
                        //     height: 25,
                        //     child: SvgPicture.asset(
                        //       AppIconsPath.orderIcon,
                        //       color: _selectedIndex == 2
                        //           ? AppColors.white
                        //           : AppColors.onyxBlack,
                        //     ),
                        //   ),
                        // ),
                      ),
                      GButton(
                        icon: Icons.home,
                        leading: SizedBox(
                          width: 25,
                          height: 25,
                          child: Obx(
                            () => SvgPicture.asset(
                              AppIconsPath.settingsIcon,
                              color: controller.selectedIndex.value == 3
                                  ? AppColors.white
                                  : AppColors.onyxBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                    selectedIndex: controller.selectedIndex.value,
                    onTabChange: (index) {
                      controller.changeIndex(index);
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
