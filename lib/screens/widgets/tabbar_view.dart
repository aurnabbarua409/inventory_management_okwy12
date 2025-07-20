// OrdersTabView.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

import '../../widgets/space_widget/space_widget.dart';

class OrdersTabView extends StatefulWidget {
  final List<Map<String, dynamic>> pendingInvoices;
  final List<Map<String, dynamic>> receivedInvoices;
  final List<Map<String, dynamic>> confirmedInvoices;

  const OrdersTabView({
    super.key,
    required this.pendingInvoices,
    required this.receivedInvoices,
    required this.confirmedInvoices,
  });

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
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
        width: ResponsiveUtils.width(400),
        child: Column(
          children: [
            Center(
              child: Container(
                width: ResponsiveUtils.width(350),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.tabBG,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TabBar(
                  controller: DefaultTabController.of(context),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: DefaultTabController.of(context).index == 0
                        ? AppColors.orange400
                        : DefaultTabController.of(context).index == 2
                            ? AppColors.brightGreen
                            : AppColors.primaryBlue,
                  ),
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  tabs: [
                    SizedBox(
                      width: ResponsiveUtils.width(105),
                      height: ResponsiveUtils.height(40),
                      child: const Center(
                        child: Text(
                          AppStrings.pendingPrice,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.width(105),
                      height: ResponsiveUtils.height(40),
                      child: const Center(
                        child: Text(
                          AppStrings.receivedPrice,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveUtils.width(105),
                      height: ResponsiveUtils.height(40),
                      child: const Center(
                        child: Text(
                          AppStrings.confirmed,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildInvoiceList(widget.pendingInvoices),
                  buildInvoiceList(widget.receivedInvoices),
                  buildInvoiceList(widget.confirmedInvoices),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInvoiceList(List<Map<String, dynamic>> invoices) {
    debugPrint("buildInvoiceList called with ${invoices.length} items");

    if (invoices.isEmpty) {
      return const Center(child: Text("No orders available"));
    }

    return ListView.builder(
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        debugPrint("Invoice at index $index: $invoice");

        return Card(
          color: AppColors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.width(16),
            vertical: ResponsiveUtils.height(6),
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
                      children: [
                        TextWidget(
                          text: invoice['company'],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.black,
                        ),
                        const SpaceWidget(spaceHeight: 4),
                        TextWidget(
                          text:
                              "Invoice: ${invoice['invoice'] ?? 'N/A'}", // Add null check
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.onyxBlack,
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
                        TextWidget(
                          text:
                              "${formatDay(invoice["date"])}\n${formatDate(invoice["date"])}",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.onyxBlack,
                        ),
                        const SpaceWidget(spaceHeight: 4),
                        GestureDetector(
                          onTap: () {
                            int currentIndex =
                                DefaultTabController.of(context).index;
                            if (currentIndex == 0) {
                              Get.toNamed(AppRoutes
                                  .retailerPendingOrderDetailsHistoryScreen);
                            } else if (currentIndex == 1) {
                              Get.toNamed(AppRoutes
                                  .retailerReceivedPriceDetailsHistoryScreen);
                            } else {
                              Get.toNamed(AppRoutes
                                  .retailerConfirmOrderDetailsHistoryScreen);
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
                      constraints:
                          const BoxConstraints(minWidth: 18, minHeight: 18),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppColors.black,
                        size: 18,
                      ),
                      color: AppColors.white,
                      onSelected: (value) {
                        if (value == 1) {
                          // Handle the delete functionality
                        }
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

String formatDate(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  return DateFormat.jm().format(dateTime);
}

String formatDay(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

  final difference = today.difference(dateOnly).inDays;

  if (difference == 0) return 'Today';
  if (difference == 1) return 'Yesterday';

  return DateFormat('d MMM yyyy').format(dateTime);
}
