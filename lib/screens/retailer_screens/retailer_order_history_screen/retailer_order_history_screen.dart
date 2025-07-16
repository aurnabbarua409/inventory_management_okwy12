// RetailerOrderHistoryScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/controller/retailer_order_history_controller.dart';
import 'package:inventory_app/screens/widgets/tabbar_view.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';

class RetailerOrderHistoryScreen extends StatelessWidget {
  RetailerOrderHistoryScreen({super.key});
  final RetailerOrderHistoryController controller =
      Get.put(RetailerOrderHistoryController());

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context); // Initialize the screen dimensions

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: Column(
          children: [
            MainAppbarWidget(
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButtonWidget(
                    onTap: () {
                      final control = Get.find<BottomNavbarController>();
                      final destination = control.selectedIndex.value - 1;
                      control.changeIndex(destination);
                    },
                    icon: AppIconsPath.backIcon,
                    color: AppColors.white,
                    size: ResponsiveUtils.width(22),
                  ),
                ),
                const Center(
                  child: TextWidget(
                    text: AppStrings.orderHistory,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.white,
                  ),
                ),
              ]),
            ),
            SizedBox(height: ResponsiveUtils.height(16)),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchPendingOrders,
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return OrdersTabView(
                      pendingInvoices: controller.pendingOrders.map((pending) {
                        return {
                          "company": pending.wholeSeller.name,
                          "date": pending.createdAt.toIso8601String(),
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(2)),
                            child: Icon(
                              Icons.business,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(30),
                            ),
                          ),
                        };
                      }).toList(),
                      receivedInvoices:
                          controller.receivedOrders.map((received) {
                        return {
                          "company": received.wholeSeller.name,
                          "date": received.createdAt.toIso8601String(),
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(4)),
                            child: Icon(
                              Icons.business_center,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(38),
                            ),
                          ),
                        };
                      }).toList(),
                      confirmedInvoices:
                          controller.confirmedOrders.map((confirmed) {
                        return {
                          "company": confirmed.wholeSeller?.name ?? "No Name",
                          "date": confirmed.createdAt?.toIso8601String() ??
                              "No Date",
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(4)),
                            child: Icon(
                              Icons.verified,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(38),
                            ),
                          ),
                        };
                      }).toList(),
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
