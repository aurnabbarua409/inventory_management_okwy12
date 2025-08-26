import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    onCheck();
  }

  void onCheck() async {
    // Wait for 3 seconds before navigating to the HomeScreen
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      // final islogin = PrefsHelper.isLogIn;
      // if (islogin) {
      //   PrefsHelper.token =
      //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTIxMWVlMTNkNWYyNjU1ZGZiZTZhYSIsInJvbGUiOiJXaG9sZXNhbGVyIiwiZW1haWwiOiJiZWtham9yMjczQG1hcmRpZWsuY29tIiwiaWF0IjoxNzU1ODQwMzgyLCJleHAiOjE3NTU5MjY3ODJ9.LPQAm0v8C-C7dKbA1-pM6ktld5-bM3dVDo7779e-4WA";

      //   final response = await ApiService.getApi(Urls.userProfile);
      //   if (response['message'] == "Session Expired") {
      //     Get.offAllNamed(AppRoutes.onboardingScreen);
      //     return;
      //   }
      //   final role = PrefsHelper.userRole;
      //   final userId = PrefsHelper.userId;
      //   Get.offAllNamed(AppRoutes.bottomNavBar,
      //       arguments: {'userRole': role, 'userId': userId});
      // } else {
      Get.offAllNamed(AppRoutes.onboardingScreen);
      // }
      //Get.to(() => BottomNavBar());
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed"); // Log message to confirm disposal
  }
}
