import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:np_career/view/user/top_company/top_company_fb.dart';

class TopCompanyController extends GetxController {
  var inputSearch = ''.obs;
  RxMap<String, bool> followedCompanyStatusMap = <String, bool>{}.obs;
  RxList<String> followedCompanyIdList = <String>[].obs;

  TopCompanyFb _fb = Get.put(TopCompanyFb());

  @override
  void onInit() {
    super.onInit();
    fetchFollowedCompanyStatus();
  }

  Future<void> toggleFollowedCompanyStatus(String companyID) async {
    await _fb.toggleFollowedJob(companyID: companyID);
    followedCompanyStatusMap[companyID] =
        !(followedCompanyStatusMap[companyID] ?? false);
  }

  Future<void> fetchFollowedCompanyStatus() async {
    final result = await _fb.getFollowedCompanyStatusAndIds();
    final List<String> ids = result['ids'] as List<String>;
    final List<bool> status = result['status'] as List<bool>;

    final Map<String, bool> statusMap = {};
    for (int i = 0; i < ids.length; i++) {
      statusMap[ids[i]] = status[i];
    }

    followedCompanyStatusMap.value = statusMap;
    followedCompanyIdList.value = ids;
  }
}
