import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class ContactUsController extends GetxController {
  final isLoading = false.obs;
  final contactUsData = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getApi(Urls.contactUs);
      isLoading.value = false;
      if (response == null) {
        return;
      }
      contactUsData.value = response['data'][0]['body'];
      appLogger(contactUsData.value);
    } catch (e) {
      appLogger(e);
    }
  }
}
