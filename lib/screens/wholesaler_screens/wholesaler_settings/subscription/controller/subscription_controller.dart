import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_profile_screen/controller/wholesaler_profile_screen_controller.dart';
import 'package:inventory_app/utils/app_logger.dart';

class SubscriptionController extends GetxController {
  final isSubscribed = false.obs;
  final totalOrders = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initial();
  }

  void initial() async {
    final control = Get.find<WholesalerProfileScreenController>();
    await control.fetchProfile();
    isSubscribed.value = PrefsHelper.isSubscribed;
    totalOrders.value = PrefsHelper.totalOrders;
    appLogger("$isSubscribed subscribe, total order: $totalOrders");
  }
}
