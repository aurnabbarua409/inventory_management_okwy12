// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inventory_app/constants/app_colors.dart';
// import 'package:inventory_app/constants/app_icons_path.dart';
// import 'package:inventory_app/constants/app_images_path.dart';
// import 'package:inventory_app/constants/app_strings.dart';
// import 'package:inventory_app/utils/app_size.dart';
// import 'package:inventory_app/widgets/appbar_widget/main_appbar_widget.dart';
// import 'package:inventory_app/widgets/image_widget/image_widget.dart';
// import 'package:inventory_app/widgets/text_widget/text_widgets.dart';

// import '../../../widgets/icon_button_widget/icon_button_widget.dart';
// import '../../widgets/wholesaler_tabbar_view.dart';

// class WholesalerNewOrderScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> pendingPriceInvoices = [
//     {
//       "company": "KS Electronics",
//       "invoice": "#ACB12345458",
//       "date": "22 Dec 2024, 3:00 PM",
//       "logo": ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: const ImageWidget(
//           height: 38,
//           width: 38,
//           imagePath: AppImagesPath.wholesalerProfileImage,
//         ),
//       ),
//     },
//     {
//       "company": "KS Electronics",
//       "invoice": "#ACB12345458",
//       "date": "22 Dec 2024, 3:00 PM",
//       "logo": ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: const ImageWidget(
//           height: 38,
//           width: 38,
//           imagePath: AppImagesPath.wholesalerProfileImage,
//         ),
//       ),
//     },
//   ];

//   final List<Map<String, dynamic>> receivedPriceInvoices = [
//     {
//       "company": "KS Electronics",
//       "invoice": "#ACB12345458",
//       "date": "22 Dec 2024, 3:00 PM",
//       "logo": ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: const ImageWidget(
//           height: 38,
//           width: 38,
//           imagePath: AppImagesPath.wholesalerProfileImage,
//         ),
//       ),
//     },
//   ];

//   final List<Map<String, dynamic>> confirmedInvoices = [
//     {
//       "company": "KS Electronics",
//       "invoice": "#ACB12345458",
//       "date": "22 Dec 2024, 3:00 PM",
//       "logo": ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: const ImageWidget(
//           height: 50,
//           width: 50,
//           imagePath: AppImagesPath.wholesalerProfileImage,
//         ),
//       ),
//     },
//     {
//       "company": "KS Electronics",
//       "invoice": "#ACB12345458",
//       "date": "22 Dec 2024, 3:00 PM",
//       "logo": ClipRRect(
//         borderRadius: BorderRadius.circular(4),
//         child: const ImageWidget(
//           height: 50,
//           width: 50,
//           imagePath: AppImagesPath.wholesalerProfileImage,
//         ),
//       ),
//     },
//   ];

//   final int initialTabIndex;

//   WholesalerNewOrderScreen({super.key, this.initialTabIndex = 0});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: AppColors.whiteLight,
//         body: Column(
//           children: [
//             MainAppbarWidget(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButtonWidget(
//                     onTap: () {
//                       Get.back();
//                     },
//                     icon: AppIconsPath.backIcon,
//                     color: AppColors.white,
//                     size: 22,
//                   ),
//                   const TextWidget(
//                     text: AppStrings.newOrder,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     fontColor: AppColors.white,
//                   ),
//                   Container(width: ResponsiveUtils.width(28)),
//                 ],
//               ),
//             ),
//             SizedBox(height: ResponsiveUtils.height(16)),
//             Expanded(
//               child: WholesalerTabView(
//                 pendingInvoices: pendingPriceInvoices,
//                 receivedInvoices: receivedPriceInvoices,
//                 confirmedInvoices: confirmedInvoices,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
