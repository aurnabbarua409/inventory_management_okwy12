import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AppCommonFunction {
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

  static Future<File> getAssetAsFile(String assetPath) async {
    // Load asset as byte data
    final byteData = await rootBundle.load(assetPath);

    // Get temp directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    // Write asset bytes to the file
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }
}
