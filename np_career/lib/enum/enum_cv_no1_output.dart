import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/cv_template/cv1/cv1.dart';
import 'package:np_career/cv_template/cv1/cv1_output.dart';
import 'package:np_career/model/cv_model.dart';

enum EnumCvNo1Output {
  cv1_no1(_cv1_no1);

  final Function(String type, CvModel model) action;

  const EnumCvNo1Output(this.action);

  void run(String type, CvModel model) => action(type, model);
}

void _cv1_no1(String type, CvModel model) {
  switch (type.toLowerCase()) {
    case 'cv1':
      Get.to(Cv1Output(cvModel: model));
      break;

    default:
      Get.snackbar("Error", "Fail");
  }
}
