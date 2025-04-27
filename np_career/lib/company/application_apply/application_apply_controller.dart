import 'package:get/get.dart';
import 'package:np_career/company/application_apply/application_apply_fb.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';

class ApplicationApplyController extends GetxController {
  ApplicationApplyFb _fb = Get.put(ApplicationApplyFb());

  Future<void> getCv(String uid, String type) async {
    try {
      CvModel model = await _fb.getCvModel(uid, type);
      EnumCvNo1Output.cv1_no1.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
