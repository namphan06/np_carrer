import 'package:get/get.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/resume_management/resume_management_fb.dart';

class ResumeManagementController extends GetxController {
  final ResumeManagementFb _fb = Get.put(ResumeManagementFb());
  var selectChoice = "np".obs;
  var searchQuery = "".obs;
  var selectedPosition = "".obs;

  Future<void> getCv(String uid, String type) async {
    try {
      CvModel model = await _fb.getCvModel(uid, type);
      EnumCvNo1Output.cv1_no1.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
