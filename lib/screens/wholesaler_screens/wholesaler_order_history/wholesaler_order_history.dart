import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/controller/wholesaler_order_history_controller.dart';
import 'package:inventory_app/screens/widgets/wholesaler_tabbar_view.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';

class WholesalerOrderHistoryScreen extends StatelessWidget {
  // Declare the initialTabIndex variable in the constructor
  final int initialTabIndex;

  // Initialize controller
  // final WholesalerOrderHistoryController controller =
  //     Get.put(WholesalerOrderHistoryController());

  // Constructor with initialTabIndex as a parameter with default value 0
  const WholesalerOrderHistoryScreen({super.key, this.initialTabIndex = 0});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context); // Initialize the screen dimensions

    return GetBuilder(
      init: WholesalerOrderHistoryController(),
      builder: (controller) => DefaultTabController(
        length: 3,
        initialIndex: initialTabIndex, // Use initialTabIndex
        child: Scaffold(
          backgroundColor: AppColors.whiteLight,
          body: Column(
            children: [
              MainAppbarWidget(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (initialTabIndex == 2)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButtonWidget(
                          onTap: () {
                            Get.back();
                          },
                          icon: AppIconsPath.backIcon,
                          color: AppColors.white,
                          size: ResponsiveUtils.width(22),
                        ),
                      ),
                    if (initialTabIndex != 2)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButtonWidget(
                          onTap: () {
                            final control = Get.find<BottomNavbarController>();
                            control.changeIndex(0);
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
                  ],
                ),
              ),
              SizedBox(
                  height: ResponsiveUtils.height(16)), // Responsive spacing
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Obx(
                        () => WholesalerTabView(
                          showDeleteOrderDialog:
                              controller.showDeleteOrderDialog,
                          pendingInvoices:
                              controller.pendingOrders.map((order) {
                            return {
                              "company": order.retailer?.name ?? "N/A",
                              "date":
                                  order.createAt ?? DateTime.now().toString(),
                              "logo": ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.width(
                                        2)), // Responsive radius
                                child: Icon(
                                  Icons.business,
                                  color: AppColors.primaryBlue,
                                  size: ResponsiveUtils.width(
                                      30), // Use responsive width for icon size
                                ),
                              ),
                              "id": order.id ?? "N/A",
                              "product": order.product ?? []
                            };
                          }).toList(),
                          receivedInvoices:
                              controller.receivedOrders.map((order) {
                            return {
                              "company": order.wholeSaler?.name ?? "N/A",
                              "date": order.wholeSaler?.createAt ?? "N/A",
                              "logo": ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.width(
                                        4)), // Responsive radius
                                child: Icon(
                                  Icons.business_center,
                                  color: AppColors.primaryBlue,
                                  size: ResponsiveUtils.width(
                                      38), // Responsive size
                                ),
                              ),
                              "id": order.wholeSaler?.id ?? "N/A",
                              "product": order.orders ?? []
                            };
                          }).toList(),
                          confirmedInvoices: {
                            "company": (controller.confirmedOrders.value
                                        ?.retailer?.isNotEmpty ??
                                    false)
                                ? controller.confirmedOrders.value!.retailer!
                                        .first.name ??
                                    ""
                                : "",
                            "date": (controller.confirmedOrders.value?.product
                                        ?.isNotEmpty ??
                                    false)
                                ? controller.confirmedOrders.value!.product!
                                    .first.createAt
                                : "",
                            "logo": ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.width(4)),
                              child: Icon(
                                Icons.verified,
                                color: AppColors.primaryBlue,
                                size: ResponsiveUtils.width(38),
                              ),
                            ),
                            "id": (controller.confirmedOrders.value?.retailer
                                        ?.isNotEmpty ??
                                    false)
                                ? controller
                                    .confirmedOrders.value!.retailer!.first.id
                                : null,
                            "product": controller.confirmedOrders.value
                          },

                          initialIndex:
                              initialTabIndex, // Passing initialTabIndex here
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
