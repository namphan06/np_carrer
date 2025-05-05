import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/my_profile_model.dart';
import 'package:np_career/model/work_experience.dart';
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

  Future<void> getCv(String uid, String type) async {
    try {
      CvModel model = await _fb.getCvModel(uid, type);
      EnumCvNo1Output.cv1_no1.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
