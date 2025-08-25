// RetailerOrderHistoryScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/controller/retailer_order_history_controller.dart';
import 'package:inventory_app/screens/widgets/tabbar_view.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
import '../../../widgets/icon_button_widget/icon_button_widget.dart';

class RetailerOrderHistoryScreen extends StatefulWidget {
  const RetailerOrderHistoryScreen({super.key});

  @override
  State<RetailerOrderHistoryScreen> createState() =>
      _RetailerOrderHistoryScreenState();
}

class _RetailerOrderHistoryScreenState
    extends State<RetailerOrderHistoryScreen> {
  final controller = Get.put(RetailerOrderHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initalize();
  }

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
                      control.changeIndex(0);
                      // final userId = PrefsHelper.userId;
                      // final role = PrefsHelper.userRole;
                      // Get.offAllNamed(AppRoutes.retailerHomeScreen,
                      //     arguments: {'userId': userId});
                      // Get.offAllNamed(AppRoutes.bottomNavBar,
                      //     arguments: {'userRole': role, 'userId': userId});
                      // // Get.back();
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
                if (controller.receivedOrders.isEmpty ||
                    controller.pendingOrders.isEmpty ||
                    controller.confirmedOrders.isEmpty)
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            controller.initalize();
                          },
                          color: AppColors.bgColor,
                          icon: const Icon(Icons.refresh)))
              ]),
            ),
            SizedBox(height: ResponsiveUtils.height(16)),
            Expanded(
              child: Obx(() {
                appLogger(
                    "pending: ${controller.pendingOrders.length}, received: ${controller.receivedOrders.length}, confirm: ${controller.confirmedOrders}");
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return OrdersTabView(
                      onRefresh: () => controller.initalize(),
                      showDeleteOrderDialog: controller.showDeleteOrderDialog,
                      pendingInvoices: controller.pendingOrders.map((pending) {
                        return {
                          "company": pending.wholesaler != null
                              ? pending.wholesaler?.storeInformation
                                      ?.businessname ??
                                  ""
                              : "",
                          "date": pending.createAt ?? "",
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(2)),
                            child: Icon(
                              Icons.business,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(30),
                            ),
                          ),
                          "id": pending.id ?? "0",
                          "products": pending.product ?? []
                        };
                      }).toList(),
                      receivedInvoices:
                          controller.receivedOrders.map((received) {
                        return {
                          "company": received
                                  .wholesaler?.storeInformation?.businessname ??
                              "N/A",
                          "date": received.createAt ?? "",
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(4)),
                            child: Icon(
                              Icons.business_center,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(38),
                            ),
                          ),
                          "id": received.id ?? "0",
                          "products": received.product ?? [],
                          "wholesaler": received.wholesaler
                        };
                      }).toList(),
                      confirmedInvoices:
                          controller.confirmedOrders.map((confirmed) {
                        return {
                          "company": confirmed
                                  .wholesaler?.storeInformation?.businessname ??
                              "N/A",
                          "date": confirmed.createAt ?? "",
                          "logo": ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.width(4)),
                            child: Icon(
                              Icons.verified,
                              color: AppColors.primaryBlue,
                              size: ResponsiveUtils.width(38),
                            ),
                          ),
                          "id": confirmed.id ?? "0",
                          "products": confirmed
                        };
                      }).toList());
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
