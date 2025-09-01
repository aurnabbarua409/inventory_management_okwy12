import 'dart:convert';

import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:share_plus/share_plus.dart';

class AppInvitelink {
  static void invite() async {
    try {
      final response = await ApiService.getApi(Urls.inviteLink);
      appLogger(response);
      if (response != null) {
        final data = response['data'] as List;
        final url = data[0]['link'];
        Share.share(
          url,
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch invite link');
      }
    } catch (e) {
      appLogger(e);
    }
  }
}
