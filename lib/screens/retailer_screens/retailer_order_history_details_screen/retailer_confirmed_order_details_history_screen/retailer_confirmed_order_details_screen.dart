import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/controller/retailer_confirmed_order_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/build_details_list_widget.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/build_invoice_table_widget.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_details_screen/retailer_confirmed_order_details_history_screen/widgets/build_summary_section_widget.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../../../widgets/icon_button_widget/icon_button_widget.dart';

class RetailerConfirmedOrderDetailsHistoryScreen extends StatefulWidget {
  const RetailerConfirmedOrderDetailsHistoryScreen({super.key});

  @override
  State<RetailerConfirmedOrderDetailsHistoryScreen> createState() =>
      _RetailerConfirmedOrderDetailsHistoryScreenState();
}

class _RetailerConfirmedOrderDetailsHistoryScreenState
    extends State<RetailerConfirmedOrderDetailsHistoryScreen> {
  // final ConfirmedOrderDetailsHistoryController confirmedController =
  //     Get.put(ConfirmedOrderDetailsHistoryController());

  @override
  Widget build(BuildContext context) {
    // Initialize ResponsiveUtils
    ResponsiveUtils.initialize(context);

    return Scaffold(
        backgroundColor: AppColors.whiteLight,
        body: GetBuilder(
          init: ConfirmedOrderDetailsHistoryController(),
          builder: (confirmedController) => Column(
            children: [
              MainAppbarWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonWidget(
                      onTap: () {
                        Get.back();
                      },
                      icon: AppIconsPath.backIcon,
                      color: AppColors.white,
                      size: 22,
                    ),
                    const TextWidget(
                      text: AppStrings.orderDetails,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.white,
                    ),
                    const SpaceWidget(spaceWidth: 28),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Obx(() {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      children: [
                        if (confirmedController.confirmedData.value != null)
                          // Order Details Section
                          BuildDetailsListWidget(
                            title: AppStrings.retailerDetails,
                            details: [
                              {
                                AppStrings.name: confirmedController
                                        .confirmedData
                                        .value
                                        ?.retailer
                                        ?.storeInformation
                                        ?.businessname ??
                                    'Someone',
                              },
                              {
                                AppStrings.address: confirmedController
                                        .confirmedData
                                        .value
                                        ?.retailer
                                        ?.storeInformation
                                        ?.location ??
                                    'N/A',
                              },
                              {
                                AppStrings.phone: confirmedController
                                        .confirmedData.value?.retailer?.phone ??
                                    "N/A",
                              },
                            ],
                          ),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Wholesaler Details Section
                        BuildDetailsListWidget(
                          title: AppStrings.wholesalerDetails,
                          details: [
                            {
                              AppStrings.name: confirmedController
                                      .confirmedData.value?.wholesaler?.name ??
                                  'N/A',
                            },
                            {
                              AppStrings.address: confirmedController
                                      .confirmedData
                                      .value
                                      ?.wholesaler
                                      ?.storeInformation
                                      ?.location ??
                                  'N/A',
                            },
                            {
                              AppStrings.phone: confirmedController
                                      .confirmedData.value?.wholesaler?.phone ??
                                  "N/A",
                            },
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Invoice Table
                        BuildInvoiceTableWidget(
                            confirmedController: confirmedController),
                        SizedBox(height: ResponsiveUtils.height(16.0)),

                        // Summary and Download Button
                        BuildSummarySectionWidget(confirmedController),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
