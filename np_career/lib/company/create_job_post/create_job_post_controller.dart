import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateJobPostController extends GetxController {
  var selectCurrencyUnit = "".obs;
  var selectCity = "".obs;
  var selectExperience = "".obs;

  RxList<RxString> listJobDescription = ["".obs].obs;
  RxList<RxString> listRequiredApplication = ["".obs].obs;
  RxList<RxString> listBenefit = ["".obs].obs;
  RxList<RxString> listWorkLocation = ["".obs].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController applicationDeadlineController = TextEditingController();
}
