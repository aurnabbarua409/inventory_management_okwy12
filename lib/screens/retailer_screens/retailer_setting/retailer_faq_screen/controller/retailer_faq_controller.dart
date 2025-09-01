import 'package:get/get.dart';
import 'package:inventory_app/models/new_version/faq_model.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';

class RetailerFaqController extends GetxController {
  final isLoading = false.obs;
  final RxList<FaqModel> faqData = <FaqModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      final response = await ApiService.getApi(Urls.faq);
      isLoading.value = false;
      if (response == null) {
        return;
      }
      for (int i = 0; i < response['data'].length; i++) {
        faqData.add(FaqModel.fromJson(response['data'][i]));
      }

      appLogger(faqData.length);
    } catch (e) {
      appLogger(e);
    }
  }
}
