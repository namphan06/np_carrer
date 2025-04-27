import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/search/search_application/search_application.dart';
import 'package:np_career/company/search/search_application/search_application_fb.dart';

class SearchApplicationController extends GetxController {
  SearchApplicationFb _fb = Get.put(SearchApplicationFb());

  var isExpanded = false.obs;
  var selectCurrencyUnit = "".obs;
  var selectExperience = "".obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxList<String> list_city = <String>[].obs;
  RxString searchQuery = ''.obs;
  RxString searchQueryC = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController minSalary = TextEditingController();
  TextEditingController maxSalary = TextEditingController();

  RxBool savedJob = false.obs;
  RxList<bool> savedApplicationStatusList = <bool>[].obs;

  // JobPostModel? job;

  // Future<void> loadJobDetail(String job_id) async {
  //   job = await _fb.getJobDetail(job_id);
  // }

  @override
  void onInit() {
    super.onInit();

    fetchSavedApplicationStatus();
  }

  List<Map<String, dynamic>> filterApplications(
      List<Map<String, dynamic>> Application) {
    final experience = selectExperience.value;
    final typeJobCategories = list_type_job_category;
    final cities = list_city;
    final nameKeyword = nameController.text.trim().toLowerCase();

    return Application.where((application) {
      if (experience.isNotEmpty &&
          application['experience']?.toString() != experience) {
        return false;
      }

      if (typeJobCategories.isNotEmpty) {
        final jobInterests =
            (application['jobInterests'] as List?)?.cast<String>() ?? [];
        if (!typeJobCategories.any((type) => jobInterests.contains(type))) {
          return false;
        }
      }

      if (cities.isNotEmpty) {
        final jobCities = (application['city'] as List?)?.cast<String>() ?? [];
        if (!cities.any((city) => jobCities.contains(city))) {
          return false;
        }
      }

      if (nameKeyword.isNotEmpty &&
          !(application['fullName']?.toString().toLowerCase() ?? '')
              .contains(nameKeyword)) {
        return false;
      }

      return true;
    }).toList();
  }

  Future<void> toggleSavedApplicationStatus(
      int index, String applicationId) async {
    await _fb.toggleSavedApplication(jobId: applicationId);
    savedApplicationStatusList[index] = !savedApplicationStatusList[index];
  }

  Future<void> fetchSavedApplicationStatus() async {
    savedApplicationStatusList.value = await _fb.getSavedApplicationsStatus();
    print(savedApplicationStatusList);
  }
}
