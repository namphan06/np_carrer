import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:np_career/view/user/search/search_job/search_job_fb.dart';

class SearchJobController extends GetxController {
  final SearchJobFb _fb = Get.put(SearchJobFb());

  var isExpanded = false.obs;
  var selectCurrencyUnit = "".obs;
  var selectExperience = "".obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxList<String> list_city = <String>[].obs;
  RxString searchQuery = ''.obs;
  RxString searchQueryC = ''.obs;

  RxString nameRole = ''.obs;

  final RxInt currentPage = 0.obs;
  final int itemsPerPage = 5;

  TextEditingController nameController = TextEditingController();
  TextEditingController minSalary = TextEditingController();
  TextEditingController maxSalary = TextEditingController();

  RxBool savedJob = false.obs;
  RxList<bool> savedJobStatusList = <bool>[].obs;
  RxList<String> savedJobIdList = <String>[].obs;
  RxString fix = ''.obs;
  // RxList<String> appliedJobIdList = <String>[].obs;
  Stream<List<String>> appliedJobIdStream() {
    return _fb.getAppliedJobIds(); // Trả về Stream từ Firebase
  }

  JobPostModel? job;

  Future<void> loadJobDetail(String job_id) async {
    job = await _fb.getJobDetail(job_id);
  }

  @override
  void onInit() async {
    super.onInit();
    // appliedJobIdList.value = [];
    savedJobStatusList.value = [];
    savedJobIdList.value = [];
    await fetchSavedJobStatus();
    await fetchSavedJobIds();
    print("Init success");
    print(savedJobStatusList);
    print(savedJobIdList);
    print(nameRole.value);
    // fetchAppliedJobIds().then((_) {
    //   print('appliedJobIdList: ${appliedJobIdList}');
    // });
  }

  List<Map<String, dynamic>> filterJobs(List<Map<String, dynamic>> jobPosts) {
    final currencyUnit = selectCurrencyUnit.value;
    final experience = selectExperience.value;
    final typeJobCategories = list_type_job_category;
    final cities = list_city;
    final nameKeyword = nameController.text.trim().toLowerCase();
    final min = int.tryParse(minSalary.text.trim());
    final max = int.tryParse(maxSalary.text.trim());

    return jobPosts.where((job) {
      final jobMin = job['minSalary'];
      final jobMax = job['maxSalary'];

      if (currencyUnit.isNotEmpty &&
          job['currencyUnit']?.toString() != currencyUnit) {
        return false;
      }

      if (experience.isNotEmpty &&
          job['experience']?.toString() != experience) {
        return false;
      }

      if (typeJobCategories.isNotEmpty) {
        final jobInterests =
            (job['jobInterests'] as List?)?.cast<String>() ?? [];
        if (!typeJobCategories.any((type) => jobInterests.contains(type))) {
          return false;
        }
      }

      if (cities.isNotEmpty) {
        final jobCities = (job['city'] as List?)?.cast<String>() ?? [];
        if (!cities.any((city) => jobCities.contains(city))) {
          return false;
        }
      }

      if (nameKeyword.isNotEmpty &&
          !(job['name']?.toString().toLowerCase() ?? '')
              .contains(nameKeyword)) {
        return false;
      }

      if (min != null) {
        if (jobMin != null && jobMax != null) {
          if (jobMin < min && jobMax < min) return false;
        } else if (jobMin != null && jobMin < min) {
          return false;
        } else if (jobMax != null && jobMax < min) {
          return false;
        }
      }

      if (max != null) {
        if (jobMin != null && jobMax != null) {
          if (jobMin > max && jobMax > max) return false;
        } else if (jobMin != null && jobMin > max) {
          return false;
        } else if (jobMax != null && jobMax > max) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void clearSearch() {
    selectCurrencyUnit.value = '';
    selectExperience.value = '';
    list_type_job_category.clear();
    list_city.clear();
    nameController.clear();
    minSalary.clear();
    maxSalary.clear();
  }

  Future<void> toggleSavedJobStatus(int index, String jobId) async {
    await _fb.toggleSavedJob(jobId: jobId);
    savedJobStatusList[index] = !savedJobStatusList[index];
  }

  Future<void> fetchSavedJobStatus() async {
    final result = await _fb.getSavedJobsStatusAndIds();
    savedJobStatusList.value = result['status'] as List<bool>;
    if (nameRole.value == "Saved Job") {
      savedJobStatusList.value =
          List<bool>.filled(savedJobStatusList.length, true);
    }
    // print(savedJobStatusList);
  }

  Future<void> fetchSavedJobIds() async {
    final result = await _fb.getSavedJobsStatusAndIds();
    savedJobIdList.value = result['ids'] as List<String>;
    // print(savedJobIdList);
  }

  // Future<void> fetchAppliedJobIds() async {
  //   final result = await _fb.getAppliedJobIds();
  //   appliedJobIdList.value = result;
  //   // print(savedJobIdList);
  // }

  String getCreatedAtLabel(Timestamp createdAt) {
    final dateTime = createdAt.toDate();
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    bool isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    if (isToday) return "New";

    if (diff.inDays >= 7) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    }
  }
}
