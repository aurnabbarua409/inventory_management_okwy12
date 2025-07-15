// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inventory_app/constants/app_colors.dart';
// import 'package:inventory_app/constants/app_strings.dart';
// import 'package:inventory_app/routes/app_routes.dart';
// import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/controller/subs_controller.dart';
// import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/payment_webview_page.dart';
// import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
// import 'package:inventory_app/widgets/button_widget/button_widget.dart';
// import 'package:inventory_app/widgets/space_widget/space_widget.dart';
// import 'package:inventory_app/widgets/text_field_widget/text_field_widget.dart';
// import 'package:inventory_app/widgets/text_widget/text_widgets.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // Import webview_flutter

// class AddCardScreen extends StatelessWidget {
//   const AddCardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PaymentController paymentController = Get.put(PaymentController());

//     return Scaffold(
//       appBar: AppbarWidget(
//         text: AppStrings.addCard,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SpaceWidget(spaceHeight: 24),
//             const TextWidget(
//               text: AppStrings.email,
//               fontSize: (14),
//               fontWeight: FontWeight.w400,
//               fontColor: AppColors.black,
//             ),
//             const SpaceWidget(spaceHeight: 8),
//             TextFieldWidget(
//               controller: TextEditingController(),
//               hintText: 'Email address',
//               maxLines: 1,
//               onChanged: (value) {
//                 paymentController// Update email in controller
//               },
//             ),
//             const SpaceWidget(spaceHeight: 24),
//             const TextWidget(
//               text: AppStrings.amount,
//               fontSize: (14),
//               fontWeight: FontWeight.w400,
//               fontColor: AppColors.black,
//             ),
//             const SpaceWidget(spaceHeight: 8),
//             TextFieldWidget(
//               controller: TextEditingController(),
//               hintText: 'Enter amount',
//               maxLines: 1,
//               onChanged: (value) {
//                 paymentController.amount.value =
//                     int.tryParse(value) ?? 0; // Update amount in controller
//               },
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width - 50,
//               child:  ButtonWidget(
//                 onPressed: () {
//                   paymentController.createPaymentPackage(); 
//                   Get.to(() => const PaymentWebViewPage()); 
//                 },
//                 label: AppStrings.makePayment,
//                 fontSize: 18,
//                 backgroundColor: AppColors.primaryBlue,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
