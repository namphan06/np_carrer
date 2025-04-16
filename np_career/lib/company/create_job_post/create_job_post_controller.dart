import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:np_career/company/create_job_post/create_job_post_fb.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:uuid/uuid.dart';

class CreateJobPostController extends GetxController {
  final CreateJobPostFb _fb = CreateJobPostFb();

  var selectCurrencyUnit = "".obs;
  var selectCity = "".obs;
  var selectExperience = "".obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxString searchQuery = ''.obs;

  RxList<RxString> listJobDescription = ["".obs].obs;
  RxList<RxString> listRequiredApplication = ["".obs].obs;
  RxList<RxString> listBenefit = ["".obs].obs;
  RxList<RxString> listWorkLocation = ["".obs].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController applicationDeadlineController = TextEditingController();
  TextEditingController timeWorkController = TextEditingController();
  TextEditingController minSalary = TextEditingController();
  TextEditingController maxSalary = TextEditingController();

  Future<void> createJobPost(String nameCompany) async {
    try {
      var uuid = Uuid();
      String randomId = uuid.v4();

      JobPostModel jobPostModel = JobPostModel(
          id: randomId,
          name: nameController.text,
          city: selectCity.value,
          experience: selectExperience.value,
          jobDescription: listJobDescription.map((e) => e.value).toList(),
          requiredApplication:
              listRequiredApplication.map((e) => e.value).toList(),
          benefits: listBenefit.map((e) => e.value).toList(),
          workLocation: listWorkLocation.map((e) => e.value).toList(),
          applicationDeadline: applicationDeadlineController.text,
          jobInterests: list_type_job_category.toList(),
          minSalary: minSalary.text.trim().isEmpty
              ? null
              : int.tryParse(minSalary.text.trim()),
          maxSalary: maxSalary.text.trim().isEmpty
              ? null
              : int.tryParse(maxSalary.text.trim()),
          currencyUnit: selectCurrencyUnit.value,
          timeWork: timeWorkController.text);

      _fb.createJobPost(jobPostModel, nameCompany, randomId);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
