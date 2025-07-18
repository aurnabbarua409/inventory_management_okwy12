import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../widgets/space_widget/space_widget.dart';

class WholesalerTabView extends StatefulWidget {
  final List<Map<String, dynamic>>? pendingInvoices;
  final List<Map<String, dynamic>>? receivedInvoices;
  final List<Map<String, dynamic>>? confirmedInvoices;
  final int initialIndex;

  const WholesalerTabView({
    super.key,
    this.pendingInvoices = const [], // Default empty list
    this.receivedInvoices = const [], // Default empty list
    this.confirmedInvoices = const [], // Default empty list
    this.initialIndex = 0, // Default to first tab
  });

  @override
  State<WholesalerTabView> createState() => _WholesalerTabViewState();
}

class _WholesalerTabViewState extends State<WholesalerTabView> {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = DefaultTabController.of(context)!;
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ResponsiveUtils.width(400), // Overall width of the widget
        child: Column(
          children: [
            Center(
              child: Container(
                width: ResponsiveUtils.width(360),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.tabBG,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _tabController.index == 0
                        ? AppColors.orange400
                        : _tabController.index == 2
                            ? AppColors.green
                            : AppColors.primaryBlue,
                  ),
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  tabs: [
                    SizedBox(
                      width: ResponsiveUtils.width(110), // Adjusted tab width
                      height: ResponsiveUtils.height(40), // Tab height
                      child: const Center(
                        child: Text(
                          AppStrings.newOrderList,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.width(110), // Adjusted tab width
                      height: ResponsiveUtils.height(40), // Tab height
                      child: const Center(
                        child: Text(
                          AppStrings.pendingOrder,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.width(110), // Adjusted tab width
                      height: ResponsiveUtils.height(40), // Tab height
                      child: const Center(
                        child: Text(
                          AppStrings.confirmedOrder,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  buildInvoiceList(widget.pendingInvoices ?? []),
                  buildInvoiceList(widget.receivedInvoices ?? []),
                  buildInvoiceList(widget.confirmedInvoices ?? []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInvoiceList(List<Map<String, dynamic>> invoices) {
    int currentIndex = DefaultTabController.of(context)!.index;
    if (invoices.isEmpty) {
      return const Center(
        child: TextWidget(
          text: "No orders available",
          fontColor: AppColors.black,
        ),
      );
    }
    return ListView.builder(
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return Card(
          color: AppColors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          margin: EdgeInsets.symmetric(
            horizontal:
                ResponsiveUtils.width(16), // Responsive horizontal margin
            vertical: ResponsiveUtils.height(6), // Responsive vertical margin
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    invoice['logo'],
                    const SpaceWidget(spaceWidth: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ResponsiveUtils.width(150),
                          child: TextWidget(
                            text: invoice['company'],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlignment: TextAlign.start,
                          ),
                        ),
                        TextWidget(
                          text: "Invoice: ${invoice['invoice']}",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.onyxBlack,
                        ),
                        const SpaceWidget(spaceHeight: 2),
                        if (currentIndex == 2)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Center(
                              child: TextWidget(
                                text: "Delivered",
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: ResponsiveUtils.width(70),
                          child: TextWidget(
                            text: invoice['date'],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.onyxBlack,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlignment: TextAlign.right,
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 4),
                        GestureDetector(
                          onTap: () {
                            int currentIndex =
                                DefaultTabController.of(context)!.index;
                            if (currentIndex == 0) {
                              Get.toNamed(
                                  AppRoutes.wholesalerNewOrderDetailsScreen);
                            } else if (currentIndex == 1) {
                              Get.toNamed(AppRoutes
                                  .wholesalerPendingOrderDetailsScreen);
                            } else {
                              Get.toNamed(AppRoutes
                                  .wholesalerConfirmedOrderDetailsScreen);
                            }
                          },
                          child: const TextWidget(
                            text: AppStrings.details,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.black,
                        size: 18,
                      ),
                      color: AppColors.white,
                      onSelected: (value) {
                        if (value == 1) {}
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text(AppStrings.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
