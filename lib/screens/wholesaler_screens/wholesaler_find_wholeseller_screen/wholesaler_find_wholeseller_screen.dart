import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_find_wholeseller_screen/controller/find_wholesaler_controller.dart';
import 'package:inventory_app/screens/widgets/search_bar_widget.dart';
import 'package:inventory_app/utils/app_size.dart';
import 'package:inventory_app/widgets/icon_button_widget/icon_button_widget.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons_path.dart';
import '../../../constants/app_strings.dart';
import '../../../widgets/appbar_widget/main_appbar_widget.dart';
import '../../../widgets/icon_widget/icon_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class WholesalerFindWholeSellerScreen extends StatelessWidget {
  WholesalerFindWholeSellerScreen({super.key});

  final searchController = TextEditingController();
    final FindWholesalerController controller = Get.put(FindWholesalerController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: Column(
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
                  text: AppStrings.findWholeSaler,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.white,
                ),
                Container(width: ResponsiveUtils.width(28)),
              ],
            ),
          ),
          const SpaceWidget(spaceHeight: 16),
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SpaceWidget(spaceHeight:8),
                  ...List.generate(5, (index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: AppColors.greyLight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: const ImageWidget(
                                  height: 82,
                                  width: 82,
                                  imagePath:
                                      AppImagesPath.wholesalerProfileImage,
                                ),
                              ),
                              const SpaceWidget(spaceWidth: 12),
                              SizedBox(
                                width: ResponsiveUtils.width(198),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconWidget(
                                          height: 14,
                                          width: 14,
                                          icon: AppIconsPath.buildingIcon,
                                        ),
                                        SpaceWidget(spaceWidth: 8),
                                        TextWidget(
                                          text: AppStrings.wholesalerName,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontColor: AppColors.onyxBlack,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    const SpaceWidget(spaceHeight: 6),
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconWidget(
                                          height: 14,
                                          width: 14,
                                          icon: AppIconsPath.telephoneIcon,
                                        ),
                                        SpaceWidget(spaceWidth: 8),
                                        TextWidget(
                                          text: AppStrings.wholesalerNumber,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontColor: AppColors.onyxBlack,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    const SpaceWidget(spaceHeight: 6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const IconWidget(
                                          height: 14,
                                          width: 14,
                                          icon: AppIconsPath.mailIcon,
                                        ),
                                        const SpaceWidget(spaceWidth: 8),
                                        SizedBox(
                                          width: ResponsiveUtils.width(170),
                                          child: const TextWidget(
                                            text: AppStrings.wholesalerMail,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.onyxBlack,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlignment: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const IconWidget(
                                          height: 14,
                                          width: 14,
                                          icon: AppIconsPath.locationIcon,
                                        ),
                                        const SpaceWidget(spaceWidth: 8),
                                        SizedBox(
                                          width: ResponsiveUtils.width(170),
                                          child: const TextWidget(
                                            text: AppStrings.wholesalerLocation,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontColor: AppColors.onyxBlack,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlignment: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
