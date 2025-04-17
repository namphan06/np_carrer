import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/view/user/search/search_job/search_job_fb.dart';

class SearchJobController {
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

  SearchJobFb _fb = Get.put(SearchJobFb());

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
      // Lọc theo đơn vị tiền tệ
      if (currencyUnit.isNotEmpty &&
          job['currencyUnit']?.toString() != currencyUnit) {
        return false;
      }

      // Lọc theo kinh nghiệm
      if (experience.isNotEmpty &&
          job['experience']?.toString() != experience) {
        return false;
      }

      // Lọc theo danh mục công việc (jobInterests là danh sách)
      if (typeJobCategories.isNotEmpty) {
        final jobInterests =
            (job['jobInterests'] as List?)?.cast<String>() ?? [];
        if (!typeJobCategories.any((type) => jobInterests.contains(type))) {
          return false;
        }
      }

      // Lọc theo thành phố (city là danh sách)
      if (cities.isNotEmpty) {
        final jobCities = (job['city'] as List?)?.cast<String>() ?? [];
        if (!cities.any((city) => jobCities.contains(city))) {
          return false;
        }
      }

      // Lọc theo tên
      if (nameKeyword.isNotEmpty &&
          !(job['name']?.toString().toLowerCase() ?? '')
              .contains(nameKeyword)) {
        return false;
      }

      if (min != null) {
        // Nếu dữ liệu có cả min và max -> kiểm tra nếu cả hai đều nhỏ hơn min => loại
        if (jobMin != null && jobMax != null) {
          if (jobMin < min && jobMax < min) return false;
        }
        // Nếu chỉ có min trong dữ liệu
        else if (jobMin != null && jobMin < min) {
          return false;
        }
        // Nếu chỉ có max trong dữ liệu
        else if (jobMax != null && jobMax < min) {
          return false;
        }
      }

// Nếu người dùng nhập max
      if (max != null) {
        // Nếu dữ liệu có cả min và max -> kiểm tra nếu cả hai đều lớn hơn max => loại
        if (jobMin != null && jobMax != null) {
          if (jobMin > max && jobMax > max) return false;
        }
        // Nếu chỉ có min trong dữ liệu
        else if (jobMin != null && jobMin > max) {
          return false;
        }
        // Nếu chỉ có max trong dữ liệu
        else if (jobMax != null && jobMax > max) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Future<void> toggleSavedJobStatus(String jobId) async {
    await _fb.toggleSavedJob(jobId: jobId);
    savedJob.value = await _fb.isJobSaved(jobId: jobId);
  }
}
