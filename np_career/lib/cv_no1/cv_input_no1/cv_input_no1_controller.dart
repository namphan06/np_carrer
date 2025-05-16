import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/cv_no1/cv_input_no1/cv_input_no1_fb.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/skill.dart';
import 'package:np_career/model/work_experience.dart';
import 'package:uuid/uuid.dart';

class CvInputNo1Controller extends GetxController {
  final CvInputNo1Fb cvInputNo1Fb = Get.put(CvInputNo1Fb());
  var selectDate = Rxn<DateTime>();
  var choiceSex = false.obs;
  var selectSex = "".obs;
  final imageUrl = ''.obs;
  final choiceType = ''.obs;
  final optionAction = 'save'.obs;
  String idCv = '';
  RxString searchQuery = ''.obs;

  TextEditingController linkImgController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController occupationalGoalsController = TextEditingController();
  TextEditingController moreInformationController = TextEditingController();
  TextEditingController introducerController = TextEditingController();

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  void onInit() {
    super.onInit();
    choiceType.value = Get.arguments['type'] ?? '';

    CvModel? model = Get.arguments['model'];
    print(model);

    if (model != null) {
      selectDate.value = model.dateOfBirth.toDate();
      imageUrl.value = model.linkImage ?? '';
      linkImgController.text = model.linkImage ?? '';
      fullNameController.text = model.fullName ?? '';
      positionController.text = model.position ?? '';
      phoneNumberController.text = model.phoneNumber ?? '';
      emailController.text = model.email ?? '';
      addressController.text = model.address ?? '';
      websiteController.text = model.website ?? '';
      occupationalGoalsController.text = model.occupationalGoals ?? '';
      moreInformationController.text = model.moreInformation ?? '';
      introducerController.text = model.introducer ?? '';
      selectSex.value = model.sex;
      idCv = model.uid;

      listSkill.value = (model.skills ?? []).map((skill) {
        return {
          "name": TextEditingController(text: skill.name ?? ''),
          "indicator":
              TextEditingController(text: skill.indicator?.toString() ?? '0'),
        };
      }).toList();

      listWorkExperience.value = (model.workExperience ?? []).map((work) {
        return {
          "company": TextEditingController(text: work.company ?? ''),
          "date": TextEditingController(text: work.date ?? ''),
          "position": TextEditingController(text: work.position ?? ''),
          "list": (work.list ?? [])
              .map((e) => TextEditingController(text: e ?? ''))
              .toList()
              .obs,
        };
      }).toList();

      listActivities.value = (model.activities ?? []).map((activity) {
        return {
          "name": TextEditingController(text: activity.name ?? ''),
          "date": TextEditingController(text: activity.date ?? ''),
          "position": TextEditingController(text: activity.position ?? ''),
          "list": (activity.list ?? [])
              .map((e) => TextEditingController(text: e ?? ''))
              .toList()
              .obs,
        };
      }).toList();

      listAward.value = (model.award ?? []).map((award) {
        return {
          "name": TextEditingController(text: award.name ?? ''),
          "date": TextEditingController(text: award.date ?? ''),
        };
      }).toList();

      listCertificate.value = (model.certificate ?? []).map((certificate) {
        return {
          "name": TextEditingController(text: certificate.name ?? ''),
          "date": TextEditingController(text: certificate.date ?? ''),
        };
      }).toList();

      listKnowledge.value = (model.knowledge ?? []).map((knowledge) {
        return {
          "school": TextEditingController(text: knowledge.school ?? ''),
          "date": TextEditingController(text: knowledge.date ?? ''),
          "list": (knowledge.list ?? [])
              .map((e) => TextEditingController(text: e ?? ''))
              .toList()
              .obs,
        };
      }).toList();
    }

    optionAction.value = Get.arguments['option'] ?? '';
  }

  RxList<Map<String, dynamic>> listSkill = <Map<String, dynamic>>[
    {"name": TextEditingController(), "indicator": TextEditingController()}
  ].obs;

  List<Skill> get skillList => listSkill.map((e) {
        return Skill.fromMap({
          'name': e['name']!.text,
          'indicator': int.tryParse(e['indicator']!.text) ?? 0,
        });
      }).toList();

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

  RxList<Map<String, dynamic>> listKnowledge = <Map<String, dynamic>>[
    {
      "school": TextEditingController(),
      "date": TextEditingController(),
      "list": <TextEditingController>[].obs
    }
  ].obs;

  List<Knowledge> get knowledgeList => listKnowledge.map((e) {
        return Knowledge.fromMap({
          'school': e['school']!.text,
          'date': e['date']!.text,
          'list': (e['list'] as RxList<TextEditingController>)
              .map((controller) => controller.text)
              .toList(),
        });
      }).toList();

  RxList<Map<String, dynamic>> listActivities = <Map<String, dynamic>>[
    {
      "name": TextEditingController(),
      "date": TextEditingController(),
      "position": TextEditingController(),
      "list": <TextEditingController>[].obs
    }
  ].obs;

  List<Activity> get activityList => listActivities.map((e) {
        return Activity.fromMap({
          'name': e['name']!.text,
          'date': e['date']!.text,
          'position': e['position']!.text,
          'list': (e['list'] as RxList<TextEditingController>)
              .map((controller) => controller.text)
              .toList(),
        });
      }).toList();

  RxList<Map<String, dynamic>> listAward = <Map<String, dynamic>>[
    {"name": TextEditingController(), "date": TextEditingController()}
  ].obs;

  List<Award> get awardList => listAward.map((e) {
        return Award.fromMap({
          'name': e['name']!.text,
          'date': e['date']!.text,
        });
      }).toList();

  RxList<Map<String, dynamic>> listCertificate = <Map<String, dynamic>>[
    {"name": TextEditingController(), "date": TextEditingController()}
  ].obs;

  List<Certificate> get certificateList => listCertificate.map((e) {
        return Certificate.fromMap({
          'name': e['name']!.text,
          'date': e['date']!.text,
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

  // Skill
  void addRowSkill() {
    listSkill.add({
      "name": TextEditingController(),
      "indicator": TextEditingController()
    }.obs);
  }

  void updateNameSkill(int index, String name) {
    listSkill[index]['name'] = name;
    refresh();
  }

  void updateIndicatorSkill(int index, String indicator) {
    int num = int.tryParse(indicator) ?? 0;
    listSkill[index]['indicator'] = num;
    refresh();
  }

  void removeRowSkill(int index) {
    if (index >= 0 && index < listSkill.length) {
      listSkill.removeAt(index);
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

  // Knowledge
  void addRowKnowledge() {
    listKnowledge.add({
      "school": TextEditingController(),
      "date": TextEditingController(),
      "list": <TextEditingController>[].obs
    }.obs);
  }

  void updateSchoolKnowledge(int index, String school) {
    listKnowledge[index]['school'] = school;
    refresh();
  }

  void updateDateKnowledge(int index, String date) {
    listKnowledge[index]['date'] = date;
    refresh();
  }

  void addDetailToListK(int index) {
    (listKnowledge[index]['list'] as RxList<TextEditingController>)
        .add(TextEditingController());
    refresh();
  }

  void updateDetailInListK(int parentIndex, int detailIndex, String text) {
    (listKnowledge[parentIndex]['list']
            as RxList<TextEditingController>)[detailIndex]
        .text = text;
    refresh();
  }

  void removeRowKnowledge(int index) {
    if (index >= 0 && index < listKnowledge.length) {
      listKnowledge.removeAt(index);
    }
  }

  void removeDetailFromKnowledge(int parentIndex, int detailIndex) {
    if (parentIndex < listKnowledge.length) {
      (listKnowledge[parentIndex]['list'] as RxList<TextEditingController>)
          .removeAt(detailIndex);
      refresh();
    }
  }

  // Activities
  void addRowActivities() {
    listActivities.add({
      "name": TextEditingController(),
      "date": TextEditingController(),
      "position": TextEditingController(),
      "list": <TextEditingController>[].obs
    }.obs);
  }

  void updateNameActivities(int index, String name) {
    listActivities[index]['name'] = name;
    refresh();
  }

  void updateDateActivities(int index, String date) {
    listActivities[index]['date'] = date;
    refresh();
  }

  void updatePositionActivities(int index, String position) {
    listActivities[index]['position'] = position;
    refresh();
  }

  void addDetailToListA(int index) {
    (listActivities[index]['list'] as RxList<TextEditingController>)
        .add(TextEditingController());
    refresh();
  }

  void updateDetailInListA(int parentIndex, int detailIndex, String text) {
    (listActivities[parentIndex]['list']
            as RxList<TextEditingController>)[detailIndex]
        .text = text;
    refresh();
  }

  void removeRowActivities(int index) {
    if (index >= 0 && index < listActivities.length) {
      listActivities.removeAt(index);
    }
  }

  void removeDetailFromActivities(int parentIndex, int detailIndex) {
    if (parentIndex < listActivities.length) {
      (listActivities[parentIndex]['list'] as RxList).removeAt(detailIndex);
      refresh();
    }
  }

  // Award
  void addRowAward() {
    listAward.add(
        {"name": TextEditingController(), "date": TextEditingController()}.obs);
  }

  void updateNameAward(int index, String name) {
    listAward[index]['name'] = name;
    refresh();
  }

  void updateDateAward(int index, String date) {
    listAward[index]['date'] = date;
    refresh();
  }

  void removeRowAward(int index) {
    if (index >= 0 && index < listAward.length) {
      listAward.removeAt(index);
    }
  }

  // Certificate
  void addRowCertificate() {
    listCertificate.add(
        {"name": TextEditingController(), "date": TextEditingController()}.obs);
  }

  void updateNameCertificate(int index, String name) {
    listCertificate[index]['name'] = name;
    refresh();
  }

  void updateDateCertificate(int index, String date) {
    listCertificate[index]['date'] = date;
    refresh();
  }

  void removeRowCertificate(int index) {
    if (index >= 0 && index < listCertificate.length) {
      listCertificate.removeAt(index);
    }
  }

  Timestamp convertToTimestamp(DateTime date) {
    return Timestamp.fromDate(date);
  }

  Future<void> addCv(String type, String type_input) async {
    try {
      var uuid = Uuid();
      String randomId = uuid.v4();
      CvModel cvModel = CvModel(
          uid: randomId,
          linkImage: imageUrl.value,
          fullName: fullNameController.text,
          position: positionController.text,
          dateOfBirth: convertToTimestamp(selectDate.value!),
          sex: selectSex.value,
          phoneNumber: phoneNumberController.text,
          email: emailController.text,
          address: addressController.text,
          website: websiteController.text,
          occupationalGoals: occupationalGoalsController.text,
          skills: skillList,
          workExperience: workExperienceList,
          knowledge: knowledgeList,
          activities: activityList,
          award: awardList,
          certificate: certificateList,
          moreInformation: moreInformationController.text,
          introducer: introducerController.text,
          type: type);

      cvInputNo1Fb.createCvNo1(cvModel, type, type_input);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<CvModel> getCvModel(String type) async {
    CvModel cvModel = CvModel(
      uid: idCv,
      linkImage: imageUrl.value,
      fullName: fullNameController.text,
      position: positionController.text,
      dateOfBirth: convertToTimestamp(selectDate.value!),
      sex: selectSex.value,
      phoneNumber: phoneNumberController.text,
      email: emailController.text,
      address: addressController.text,
      website: websiteController.text,
      occupationalGoals: occupationalGoalsController.text,
      skills: skillList,
      workExperience: workExperienceList,
      knowledge: knowledgeList,
      activities: activityList,
      award: awardList,
      certificate: certificateList,
      moreInformation: moreInformationController.text,
      introducer: introducerController.text,
      type: type,
    );
    return cvModel;
  }

  Future<void> updateCv(String type) async {
    try {
      print("===> Đã vào hàm updateCv với type: $type");

      CvModel cvModel = CvModel(
        uid: idCv,
        linkImage: imageUrl.value,
        fullName: fullNameController.text,
        position: positionController.text,
        dateOfBirth: convertToTimestamp(selectDate.value!),
        sex: selectSex.value,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        address: addressController.text,
        website: websiteController.text,
        occupationalGoals: occupationalGoalsController.text,
        skills: skillList,
        workExperience: workExperienceList,
        knowledge: knowledgeList,
        activities: activityList,
        award: awardList,
        certificate: certificateList,
        moreInformation: moreInformationController.text,
        introducer: introducerController.text,
        type: type,
      );

      // Print out each field of cvModel
      print("===> cvModel details:");
      print("uid: ${cvModel.uid}");
      print("linkImage: ${cvModel.linkImage}");
      print("fullName: ${cvModel.fullName}");
      print("position: ${cvModel.position}");
      print("dateOfBirth: ${cvModel.dateOfBirth}");
      print("sex: ${cvModel.sex}");
      print("phoneNumber: ${cvModel.phoneNumber}");
      print("email: ${cvModel.email}");
      print("address: ${cvModel.address}");
      print("website: ${cvModel.website}");
      print("occupationalGoals: ${cvModel.occupationalGoals}");
      print("skills: ${cvModel.skills}");
      print("workExperience: ${cvModel.workExperience}");
      print("knowledge: ${cvModel.knowledge}");
      print("activities: ${cvModel.activities}");
      print("award: ${cvModel.award}");
      print("certificate: ${cvModel.certificate}");
      print("moreInformation: ${cvModel.moreInformation}");
      print("introducer: ${cvModel.introducer}");
      print("type: ${cvModel.type}");

      print("===> cvInputNo1Fb: $cvInputNo1Fb");
      await cvInputNo1Fb.updateCvNo1(cvModel, type);
      print("success");
    } catch (err) {
      Get.snackbar("Error update", err.toString());
    }
  }
}
