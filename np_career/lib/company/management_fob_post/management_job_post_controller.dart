import 'package:get/get.dart';

class ManagementJobPostController extends GetxController {
  var inputSearch = ''.obs;
  final RxInt currentPage = 0.obs;
  final int itemsPerPage = 5;
  final filteredJobs2 = [].obs;
  List<RxBool> createExpandedList(int length) {
    return List.generate(length, (_) => false.obs);
  }
}
