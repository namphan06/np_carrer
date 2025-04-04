import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
