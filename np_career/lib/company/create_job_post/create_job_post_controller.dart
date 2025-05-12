import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:np_career/company/create_job_post/create_job_post_fb.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:uuid/uuid.dart';

class CreateJobPostController extends GetxController {
  final CreateJobPostFb _fb = CreateJobPostFb();

  var selectCurrencyUnit = "".obs;
  var optionAction;
  var jobId; // var selectCity = "".obs;
  var selectExperience = "".obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxList<String> list_city = <String>[].obs;
  RxString searchQuery = ''.obs;
  RxString searchQueryC = ''.obs;

  RxList<RxString> listJobDescription = ["".obs].obs;
  RxList<RxString> listRequiredApplication = ["".obs].obs;
  RxList<RxString> listBenefit = ["".obs].obs;
  RxList<RxString> listWorkLocation = ["".obs].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController applicationDeadlineController = TextEditingController();
  TextEditingController timeWorkController = TextEditingController();
  TextEditingController minSalary = TextEditingController();
  TextEditingController maxSalary = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    optionAction = Get.arguments['type'];
    if (optionAction == 'update') {
      jobId = Get.arguments?['jobId'];
      if (jobId != null) {
        loadJobData(jobId);
      }
    }
  }

  Future<void> loadJobData(String jobId) async {
    try {
      JobPostModel model = await _fb.getDataJob(jobId);

      // Gán dữ liệu vào các controller và Rx
      nameController.text = model.name;
      applicationDeadlineController.text = model.applicationDeadline;
      timeWorkController.text = model.timeWork;
      minSalary.text = model.minSalary?.toString() ?? '';
      maxSalary.text = model.maxSalary?.toString() ?? '';
      selectCurrencyUnit.value = model.currencyUnit ?? '';
      selectExperience.value = model.experience;
      // assignAll gán toàn bộ phần tử trong mảng vào RxList
      list_city.assignAll(model.city);
      list_type_job_category.assignAll(model.jobInterests);
      listJobDescription
          .assignAll(model.jobDescription.map((e) => e.obs).toList());
      listRequiredApplication
          .assignAll(model.requiredApplication.map((e) => e.obs).toList());
      listBenefit.assignAll(model.benefits.map((e) => e.obs).toList());
      listWorkLocation.assignAll(model.workLocation.map((e) => e.obs).toList());
    } catch (err) {
      Get.snackbar("Error", "Không thể tải dữ liệu công việc");
    }
  }

  Future<void> createJobPost(String nameCompany) async {
    try {
      var uuid = Uuid();
      String randomId = uuid.v4();

      JobPostModel jobPostModel = JobPostModel(
          id: randomId,
          name: nameController.text,
          city: list_city.toList(),
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

  Future<void> updateJobPost(String nameCompany) async {
    try {
      JobPostModel jobPostModel = JobPostModel(
          id: jobId,
          name: nameController.text,
          city: list_city.toList(),
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

      _fb.updateJobPost(jobId, jobPostModel, nameCompany);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
