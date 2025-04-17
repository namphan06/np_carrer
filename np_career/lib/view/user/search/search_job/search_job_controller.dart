import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchJobController {
  var isExpanded = false.obs;
  var selectCurrencyUnit = "".obs;
  // var selectCity = "".obs;
  var selectExperience = "".obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxList<String> list_city = <String>[].obs;
  RxString searchQuery = ''.obs;
  RxString searchQueryC = ''.obs;

  TextEditingController nameController = TextEditingController();

  TextEditingController minSalary = TextEditingController();
  TextEditingController maxSalary = TextEditingController();
}
