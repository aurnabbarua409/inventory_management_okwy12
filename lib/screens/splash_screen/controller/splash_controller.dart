import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Wait for 3 seconds before navigating to the HomeScreen
    Future.delayed(const Duration(seconds: 3)).then((_) {
      final islogin = PrefsHelper.isLogIn;
      if (islogin) {
        final role = PrefsHelper.userRole;
        final userId = PrefsHelper.userId;
        Get.offAllNamed(AppRoutes.bottomNavBar,
            arguments: {'userRole': role, 'userId': userId});
      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
      //Get.to(() => BottomNavBar());
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed"); // Log message to confirm disposal
  }
}
