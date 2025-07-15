import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/widgets/image_widget/image_widget.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  //change to stateful
  const SplashScreen({super.key});

//  @override
//   class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(
//       const Duration(seconds: 3),
//       () {
//         // if (PrefsHelper.isLogIn) {
//         //   if (PrefsHelper.myRole == 'consultant') {
//         //     Get.offAllNamed(AppRoutes.doctorHome);
//         //   } else {
//         //     Get.offAllNamed(AppRoutes.patientsHome);
//         //   }
//         // } else {
//           Get.offAllNamed(AppRoutes.onboarding);

//       },
//     );
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable

    final splashController = Get.put(SplashController());

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImagesPath.splashBg),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: ImageWidget(
              imagePath: AppImagesPath.appLogo,
              height: 350,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
