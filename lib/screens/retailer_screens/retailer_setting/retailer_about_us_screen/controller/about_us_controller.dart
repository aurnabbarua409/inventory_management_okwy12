import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class AboutUsController extends GetxController {
  final isLoading = false.obs;
  final aboutUsData = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getApi(Urls.aboutUs);
      isLoading.value = false;
      if (response == null) {
        return;
      }
      aboutUsData.value = response['data'][0]['body'];
      appLogger(aboutUsData.value);
    } catch (e) {
      appLogger(e);
    }
  }
}
