import 'package:get/get.dart';
import 'package:np_career/cv_template/cv1/cv1_output.dart';
import 'package:np_career/cv_template/cv2/cv2_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/view/user/job_applied/job_applied.dart';

enum EnumCvOutput {
  cv1_no1(_cv1_no1),
  cv2_no2(_cv2_no2);

  final void Function(String type, dynamic model) action;

  const EnumCvOutput(this.action);

  void run(String type, dynamic model) => action(type, model);
}

// === Handlers ===

void _cv1_no1(String type, dynamic model) {
  if (model is CvModel) {
    switch (type.toLowerCase()) {
      case 'cv1':
        Get.to(() => Cv1Output(cvModel: model));
        break;
      default:
        Get.snackbar("Error", "Unknown CV type for CvModel: $type");
    }
  } else {
    Get.snackbar("Error", "Invalid model type for cv1_no1");
  }
}

void _cv2_no2(String type, dynamic model) {
  if (model is CvModelV2) {
    switch (type.toLowerCase()) {
      case 'cv2':
        Get.to(() => Cv2Output(model: model));
        break;
      default:
        Get.snackbar("Error", "Unknown CV type for CvModelV2: $type");
    }
  } else {
    Get.snackbar("Error", "Invalid model type for cv2_no2");
  }
}
