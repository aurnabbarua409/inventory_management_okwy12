import 'package:get/get.dart';

class ToggleButtonController extends GetxController {
  var isSwitched = false.obs;

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
  }
}
