import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/services/socket_service.dart' show SocketApi;

import 'main_app_entry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.getAllPrefData();
  //NotificationService.initLocalNotification();
  SocketApi.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}
