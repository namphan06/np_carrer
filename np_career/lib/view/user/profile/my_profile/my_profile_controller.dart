import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/my_profile_model.dart';
import 'package:np_career/model/work_experience.dart';
import 'package:np_career/view/pdf_viewr.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_fb.dart';

class MyProfileController extends GetxController {
  final MyProfileFb _fb = Get.put(MyProfileFb());
  var selectDate = Rxn<DateTime>();
  var choiceSex = false.obs;
  var selectSex = "".obs;
  var isSharing = RxnBool();
  var selectedPosition = "".obs;
  var typeCv = "".obs;
  var idCv = "".obs;
  RxString searchQueryC = ''.obs;
  RxList<String> list_type_job = <String>[].obs;
  RxList<String> list_type_job_category = <String>[].obs;
  RxList<String> list_city = <String>[].obs;
  RxString searchQuery = ''.obs;

  RxString selectedNationality = "".obs;
  RxString selectedEducationLevel = "".obs;

  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hiringReason = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMyProfile();
  }

  Future<void> loadMyProfile() async {
    try {
      final profile = await _fb.getMyProfile();
      if (profile != null) {
        fullName.text = profile.fullName ?? '';
        phoneNumber.text = profile.phoneNumber ?? '';
        address.text = profile.address ?? '';
        hiringReason.text = profile.hiringReason ?? '';

        selectedNationality.value = profile.nationality ?? '';
        selectedEducationLevel.value = profile.educationLevel ?? '';
        selectSex.value = profile.sex ?? '';
        isSharing.value = profile.securitySetting;
        selectedPosition.value = profile.resumePosition ?? '';
        typeCv.value = profile.resumeType ?? '';
        idCv.value = profile.resumeId ?? '';
        selectDate.value = profile.dateOfBirth?.toDate();

        list_type_job.value = profile.preferredJobType ?? [];
        list_type_job_category.value = profile.jobInterests ?? [];
        list_city.value = profile.city ?? [];

        // Gán Work Experience
        listWorkExperience.clear();
        for (var item in profile.workExperience) {
          listWorkExperience.add({
            "company": TextEditingController(text: item.company),
            "date": TextEditingController(text: item.date),
            "position": TextEditingController(text: item.position),
            "list": item.list
                .map((e) => TextEditingController(text: e))
                .toList()
                .obs,
          }.obs);
        }

        update();
      } else {
        // Get.snackbar("Thông báo", "Không tìm thấy hồ sơ người dùng.");
      }
    } catch (err) {
      Get.snackbar("Lỗi", err.toString());
    }
  }

  RxList<Map<String, dynamic>> listWorkExperience = <Map<String, dynamic>>[
    {
      "company": TextEditingController(),
      "date": TextEditingController(),
      "position": TextEditingController(),
      "list": <TextEditingController>[].obs
    }
  ].obs;

  List<WorkExperience> get workExperienceList => listWorkExperience.map((e) {
        return WorkExperience.fromMap({
          'company': e['company']!.text,
          'date': e['date']!.text,
          'position': e['position']!.text,
          'list': (e['list'] as RxList<TextEditingController>)
              .map((controller) => controller.text)
              .toList(),
        });
      }).toList();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2600),
      initialDate: selectDate.value ?? DateTime.now(),
    );
    if (picked != null) {
      selectDate.value = picked;
    }
  }

  // Work Experience
  void addRowWorkExperience() {
    listWorkExperience.add({
      "company": TextEditingController(),
      "date": TextEditingController(),
      "position": TextEditingController(),
      "list": <TextEditingController>[].obs
    }.obs);
  }

  void addDetailToList(int index) {
    (listWorkExperience[index]['list'] as RxList<TextEditingController>)
        .add(TextEditingController());
    refresh();
  }

  void updateDetailInList(int parentIndex, int detailIndex, String text) {
    (listWorkExperience[parentIndex]['list']
            as RxList<TextEditingController>)[detailIndex]
        .text = text;
    refresh();
  }

  void removeRowWorkExperience(int index) {
    if (index >= 0 && index < listWorkExperience.length) {
      listWorkExperience.removeAt(index);
      refresh();
    }
    print(listWorkExperience);
  }

  void removeDetailFromWorkExperience(int parentIndex, int detailIndex) {
    if (parentIndex < listWorkExperience.length) {
      (listWorkExperience[parentIndex]['list'] as RxList<TextEditingController>)
          .removeAt(detailIndex);
      refresh();
    }
  }

  Timestamp convertToTimestamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> createMyProfile() async {
    try {
      MyProfileModel myProfileModel = MyProfileModel(
          fullName: fullName.text,
          phoneNumber: phoneNumber.text,
          address: address.text,
          nationality: selectedNationality.value,
          educationLevel: selectedEducationLevel.value,
          dateOfBirth: convertToTimestamp(selectDate.value!),
          sex: selectSex.value,
          hiringReason: hiringReason.text,
          workExperience: workExperienceList,
          preferredJobType: list_type_job,
          jobInterests: list_type_job_category,
          securitySetting: isSharing.value ?? false,
          resumePosition: selectedPosition.value,
          resumeType: typeCv.value,
          resumeId: idCv.value,
          city: list_city);
      _fb.saveMyProfile(myProfileModel);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  // Future<void> getCv(String uid, String type) async {
  //   try {
  //     CvModel model = await _fb.getCvModel(uid, type);
  //     EnumCvOutput.cv1_no1.run(type, model);
  //   } catch (err) {
  //     Get.snackbar("Error", err.toString());
  //   }
  // }

  Future<void> getCv(String uid, String type) async {
    try {
      dynamic model = await _fb.getCvModel(uid, type);
      CvOutputRouter.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> getCvUpload(String uid) async {
    try {
      Map<String, dynamic> model = await _fb.getCvUpload(uid);
      if (model.isNotEmpty) {
        Get.to(PdfViewrScreen(
            pdfLink: model['link'], position: model["position"]));
      } else {
        Get.snackbar("Notification", "Uploaded CV not found.");
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
