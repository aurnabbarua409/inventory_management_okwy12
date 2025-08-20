import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:share_plus/share_plus.dart';

class AppInvitelink {
  static void invite() async {
    final response = await ApiService.getApi(Urls.inviteLink);
    appLogger(response);
    if (response != null &&
        response['data'] != null &&
        response['data']['link'] != null) {
      final url = response['data']['link'];
      Share.share(
        url,
      );
    } else {
      Get.snackbar('Error', 'Failed to fetch invite link');
    }
  }
}
