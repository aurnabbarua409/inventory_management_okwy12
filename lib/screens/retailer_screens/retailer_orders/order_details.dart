import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/constants/app_icons_path.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
import 'package:inventory_app/widgets/button_widget/button_widget.dart';
import 'package:inventory_app/widgets/icon_widget/icon_widget.dart';
import 'package:inventory_app/widgets/space_widget/space_widget.dart';
import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

class OrderDetails extends StatelessWidget {
  final List<Map<String, dynamic>>? data;

  // ignore: use_super_parameters
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = data ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: Column(
        children: [
          MainAppbarWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 28),
                const TextWidget(
                  text: AppStrings.details,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    isLabelVisible: true,
                    label: Text("0"),
                    backgroundColor: AppColors.extremelyRed,
                    child: IconWidget(
                      height: 24,
                      width: 24,
                      icon: AppIconsPath.notificationIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SpaceWidget(spaceHeight: 16),

          // Table Header
          SizedBox(
            child: Container(
              color: AppColors.lightBlue,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.serial,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(AppStrings.product,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(AppStrings.quantity,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(AppStrings.unit,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Table Body
          Expanded(
            child: orderData.isNotEmpty
                ? SizedBox(
                    width: 40,
                    height: 80,
                    child: ListView.builder(
                      itemCount: orderData.length,
                      itemBuilder: (context, index) {
                        final item = orderData[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item[AppStrings.serial] ?? ''),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    item[AppStrings.product] ?? '',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              Text(item[AppStrings.quantity] ?? ''),
                              Text(item[AppStrings.unit] ?? ''),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text(AppStrings.dataNotFound),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      // controller.resetPassword();
                    },
                    label: AppStrings.update,
                    backgroundColor: AppColors.primaryBlue,
                    buttonWidth: 100.0,
                    buttonHeight: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
