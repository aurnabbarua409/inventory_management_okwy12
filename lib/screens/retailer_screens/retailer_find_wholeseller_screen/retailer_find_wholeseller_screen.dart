import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/controller/find_wholesaler_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/widget/wholesaler_profile_card.dart';
import 'package:inventory_app/screens/widgets/search_bar_widget.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class RetailerFindWholeSellerScreen extends StatelessWidget {
  const RetailerFindWholeSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: GetBuilder(
        init: FindWholesalerController(),
        builder: (controller) => Column(
          children: [
            // AppBar Section
            MainAppbarWidget(
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButtonWidget(
                    onTap: () {
                      final control = Get.find<BottomNavbarController>();
                      control.changeIndex(0);
                      controller.filteredWholesalers.clear();
                    },
                    icon: AppIconsPath.backIcon,
                    color: AppColors.white,
                    size: ResponsiveUtils.width(22),
                  ),
                ),
                const Center(
                  child: TextWidget(
                    text: AppStrings.findWholeSaler,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.white,
                  ),
                ),
              ]),
            ),
            const SpaceWidget(spaceHeight: 16),

            // Search Bar Section

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchBarWidget(
                      controller: controller.searchController,
                      hintText: 'Search by name, email or phone',
                      maxLines: 1,
                      onChanged: (query) {
                        controller.filterWholesalers(query);
                      },
                    ),
                  ),
                  const SpaceWidget(spaceWidth: 12),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                        width: ResponsiveUtils.width(56),
                        height: ResponsiveUtils.width(56),
                        padding: const EdgeInsets.all(13),
                        decoration: ShapeDecoration(
                          color: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Center(
                          child: IconWidget(
                            height: 25,
                            width: 25,
                            icon: AppIconsPath.searchIcon,
                          ),
                        )),
                  )
                ],
              ),
            ),

            const SpaceWidget(spaceHeight: 8),

            // Filtered List of Wholesalers based on the search query

            Expanded(child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.filteredWholesalers.isEmpty) {
                return const Center(
                    child: Text("There is no wholesaler found"));
              }
              return RefreshIndicator(
                onRefresh: () => controller.fetchWholesalers(),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: controller.filteredWholesalers.length,
                  itemBuilder: (context, index) {
                    final wholesaler = controller.filteredWholesalers[index];
                    final isCardSelected = controller.selectedItems.isEmpty
                        ? false
                        : controller.selectedItems[index];
                    appLogger(wholesaler);
                    appLogger(isCardSelected);

                    return GestureDetector(
                      onTap: () {
                        controller.toggleSelection(index, !isCardSelected);
                      },
                      child: WholesalerProfileCard(
                        wholesaler: wholesaler,
                        isSelected: isCardSelected,
                        onLongPress: (isSelected) {
                          controller.toggleSelection(index, isSelected);
                        },
                        onDoubleTap: (_) {
                          controller.deselect(index);
                        },
                        onTap: () {
                          controller.showSendOrderDialog(context);
                        },
                      ),
                    );
                  },
                ),
              );
            })),

            // Show send order button if items are selected
            Obx(() {
              int selectedCount =
                  controller.selectedItems.where((item) => item).length;
              return selectedCount > 0
                  ? Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              text: "$selectedCount Selected",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: AppColors.white),
                          Obx(() => controller.isSendingOrder.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : ButtonWidget(
                                  onPressed: () {
                                    if (controller.selectedProductIds.isEmpty) {
                                      Get.snackbar('No product selected',
                                          'Please select the product');
                                      return;
                                    }
                                    controller.showSendOrderDialog(context);
                                  },
                                  label: "Send",
                                  backgroundColor: AppColors.white,
                                  textColor: AppColors.primaryBlue,
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                )),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
