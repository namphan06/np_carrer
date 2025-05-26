import 'package:get/get.dart';

class ManagementJobPostController extends GetxController {
  var inputSearch = ''.obs;
  List<RxBool> createExpandedList(int length) {
    return List.generate(length, (_) => false.obs);
  }
}
