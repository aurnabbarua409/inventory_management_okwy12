import 'package:flutter/material.dart';

class Pkeys {
  static const String accessToken = "accessToken";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = Pkeys.navigatorKey.currentContext!;
}
