import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final RxInt selectedIndex = 0.obs;

  void changeIndex(int value) {
    selectedIndex.value = value;
    update();
  }
}
