import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/model/cv_model_v3.dart';
import 'package:np_career/resume_management/resume_management_fb.dart';

class ResumeManagementController extends GetxController {
  final ResumeManagementFb _fb = Get.put(ResumeManagementFb());
  var selectChoice = "np".obs;
  var searchQuery = "".obs;
  var selectedPosition = "".obs;
  var linkImage = "".obs;

  TextEditingController linkController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  Future<void> getCv(String uid, String type) async {
    try {
      dynamic model = await _fb.getCvModel(uid, type);
      CvOutputRouter.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> uploadCv() async {
    try {
      await _fb.uploadCv(linkController.text, positionController.text);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getCvsWithLinks(List cvs) async {
    List<Map<String, dynamic>> result = [];

    for (var e in cvs) {
      var cv = e as Map<String, dynamic>;
      var position = (cv["position"] ?? "").toString().toLowerCase();

      if (cv["type"] == "upload" &&
          position.contains(selectedPosition.value.toLowerCase())) {
        String link = await _fb.getLink(cv['id']);
        result.add({...cv, 'link': link});
      }
    }

    return result;
  }
}
