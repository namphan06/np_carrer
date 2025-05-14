import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/cv_no1/cv_input_no1/cv_input_no1.dart';
import 'package:np_career/cv_no1/cv_input_no2/cv_input_no2.dart';

enum EnumCvInput {
  cv_input(_cv_input);

  final void Function(
      String inputType, String typeCv, String option, dynamic model) action;

  const EnumCvInput(this.action);

  void run(String inputType, String typeCv, String option, dynamic model) {
    action(inputType, typeCv, option, model);
  }
}

void _cv_input(String inputType, String typeCv, String option, dynamic model) {
  switch (inputType.toLowerCase()) {
    case 'no1':
      Get.to(() => CvInputNo1(),
          arguments: {'type': typeCv, 'option': option, 'model': model});
      break;
    case 'no2':
      Get.to(() => CvInputNo2(),
          arguments: {'type': typeCv, 'option': option, 'model': model});
      break;
    default:
      Get.snackbar("Error", "Unknown input type: $inputType");
  }
}
