import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  var selectDate = Rxn<DateTime>();
  var choiceSex = false.obs;
  var selectSex = "".obs;
  var isSharing;

  RxList<Map<String, dynamic>> listWorkExperience = <Map<String, dynamic>>[
    {
      "company": TextEditingController(),
      "date": TextEditingController(),
      "position": TextEditingController(),
      "list": <TextEditingController>[].obs
    }
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
}
