import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CvInputNo1Controller extends GetxController {
  var selectDate = Rxn<DateTime>();
  var choiceSex = false.obs;
  var selectSex = "".obs;
  RxList<Map<String, dynamic>> listSkill = <Map<String, dynamic>>[
    {"name": "", "indicator": 0}
  ].obs;
  RxList<Map<String, dynamic>> listWorkExperience = <Map<String, dynamic>>[
    {"company": "", "date": "", "position": "", "list": [].obs}
  ].obs;
  RxList<Map<String, dynamic>> listKnowledge = <Map<String, dynamic>>[
    {"school": "", "date": "", "list": [].obs}
  ].obs;
  RxList<Map<String, dynamic>> listActivities = <Map<String, dynamic>>[
    {"name": "", "date": "", "position": "", "list": [].obs}
  ].obs;
  RxList<Map<String, dynamic>> listAward = <Map<String, dynamic>>[
    {"name": "", "date": ""}
  ].obs;
  RxList<Map<String, dynamic>> listCertificate = <Map<String, dynamic>>[
    {"name": "", "date": ""}
  ].obs;
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

  void addRowSkill() {
    listSkill.add({"name": "", "indicator": 0});
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

  void addRowWorkExperience() {
    listWorkExperience
        .add({"company": "", "date": "", "position": "", "list": [].obs});
  }

  void updateCompanyWorkExperience(int index, String name) {
    listSkill[index]['company'] = name;
    refresh();
  }

  void updateDateWorkExperience(int index, String date) {
    listSkill[index]['date'] = date;
    refresh();
  }

  void updatePositionWorkExperience(int index, String position) {
    listSkill[index]['position'] = position;
    refresh();
  }

  void addDetailToList(int index) {
    (listWorkExperience[index]['list'] as List).add("");
    refresh();
  }

  void updateDetailInList(int parentIndex, int detailIndex, String text) {
    (listWorkExperience[parentIndex]['list'] as List)[detailIndex] = text;
    refresh();
  }

  void addRowKnowledge() {
    listKnowledge.add({"school": "", "date": "", "list": [].obs});
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
    (listKnowledge[index]['list'] as List).add("");
    refresh();
  }

  void updateDetailInListK(int parentIndex, int detailIndex, String text) {
    (listKnowledge[parentIndex]['list'] as List)[detailIndex] = text;
    refresh();
  }

  void addRowActivities() {
    listActivities
        .add({"name": "", "date": "", "position": "", "list": [].obs});
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
    (listActivities[index]['list'] as List).add("");
    refresh();
  }

  void updateDetailInListA(int parentIndex, int detailIndex, String text) {
    (listActivities[parentIndex]['list'] as List)[detailIndex] = text;
    refresh();
  }

  void addRowAward() {
    listAward.add({"name": "", "date": ""});
  }

  void updateNameAward(int index, String name) {
    listAward[index]['name'] = name;
    refresh();
  }

  void updateDateAward(int index, String date) {
    listAward[index]['date'] = date;
    refresh();
  }

  void addRowCertificate() {
    listCertificate.add({"name": "", "date": ""});
  }

  void updateNameCertificate(int index, String name) {
    listCertificate[index]['name'] = name;
    refresh();
  }

  void updateDateCertificate(int index, String date) {
    listCertificate[index]['date'] = date;
    refresh();
  }
}
