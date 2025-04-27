import 'package:get/get.dart';

class ManagementJobPostController {
  List<RxBool> createExpandedList(int length) {
    return List.generate(length, (_) => false.obs);
  }
}
