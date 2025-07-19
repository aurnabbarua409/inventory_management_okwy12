import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/screens/bottom_nav_bar/controller/bottom_navbar_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/controller/find_wholesaler_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/widget/wholesaler_profile_card.dart';
import 'package:inventory_app/screens/widgets/search_bar_widget.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/outlined_button_widget/outlined_button_widget.dart';
import '../../../widgets/popup_widget/popup_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class RetailerFindWholeSellerScreen extends StatelessWidget {
  RetailerFindWholeSellerScreen({super.key});

  final searchController = TextEditingController();
  final FindWholesalerController controller =
      Get.put(FindWholesalerController()); // GetX controller

  void showSendOrderDialog(String wholesalerId, BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: TextWidget(
            text: AppStrings.areYouSure,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.areYouSureDesc,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButtonWidget(
                  onPressed: () {
                    Get.back();
                    showSendOrderSuccessfulDialog(wholesalerId, context);
                  },
                  label: AppStrings.no,
                  backgroundColor: AppColors.white,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  textColor: AppColors.primaryBlue,
                  borderColor: AppColors.primaryBlue,
                  fontSize: 14,
                ),
              ),
              const SpaceWidget(spaceWidth: 16),
              Expanded(
                flex: 1,
                child: ButtonWidget(
                  onPressed: () {
                    Get.back();
                    showSendOrderSuccessfulDialog(wholesalerId, context);
                  },
                  label: AppStrings.yes,
                  backgroundColor: AppColors.primaryBlue,
                  buttonWidth: 120,
                  buttonHeight: 36,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  // Show a popup asking to share the app with the phone number

  void showSendOrderSuccessfulDialog(
      String wholesalerId, BuildContext context) {
    showCustomPopup(
      context,
      [
        Align(
          alignment: Alignment.centerRight,
          child: IconButtonWidget(
            onTap: () {
              Get.back();
            },
            icon: AppIconsPath.closeIcon,
            size: 20,
            color: AppColors.black,
          ),
        ),
        const SpaceWidget(spaceHeight: 16),
        const Center(
          child: ImageWidget(
            height: 64,
            width: 64,
            imagePath: AppImagesPath.checkImage,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        const Center(
          child: TextWidget(
            text: AppStrings.orderSentSuccessfully,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.primaryBlue,
          ),
        ),
        const SpaceWidget(spaceHeight: 2),
        const Center(
          child: TextWidget(
            text: AppStrings.orderSentSuccessfullyDesc,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.onyxBlack,
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: OutlinedButtonWidget(
              onPressed: () {
                Get.offNamed(AppRoutes.retailerOrderHistoryScreen);
              },
              label: AppStrings.orderHistory,
              backgroundColor: AppColors.white,
              buttonWidth: 130,
              buttonHeight: 36,
              textColor: AppColors.primaryBlue,
              borderColor: AppColors.primaryBlue,
              fontSize: 14,
            ),
          ),
        ),
        const SpaceWidget(spaceHeight: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: Column(
        children: [
          // AppBar Section
          MainAppbarWidget(
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomLeft,
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
                    controller: searchController,
                    hintText: 'Search by name, email or phone number',
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

          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.filteredWholesalers.isEmpty) {
                return const Center(
                    child: Text("There is no wholesaler found"));
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.filteredWholesalers.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final wholesaler = controller.filteredWholesalers[index];
                    final isCardSelected = controller.selectedItems[index];

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
                  });
                },
              );
            }),
          )),

          // Show send order button if items are selected
          Obx(() {
            int selectedCount =
                controller.selectedItems.where((item) => item).length;
            return selectedCount > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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
                                  controller.showSendOrderDialog(context);
                                },
                                label: "Send",
                                backgroundColor: AppColors.white,
                                textColor: AppColors.primaryBlue,
                                buttonHeight: 36,
                                buttonWidth: 140,
                              )),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
