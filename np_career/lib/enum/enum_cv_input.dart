import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/cv_no1/cv_input_no1/cv_input_no1.dart';
import 'package:np_career/cv_no1/cv_input_no2/cv_input_no2.dart';

enum EnumCvInput {
  cv_input(_cv_input);

  final void Function(String inputType, String typeCv, String option) action;

  const EnumCvInput(this.action);

  void run(String inputType, String typeCv, String option) {
    action(inputType, typeCv, option);
  }
}

void _cv_input(String inputType, String typeCv, String option) {
  switch (inputType.toLowerCase()) {
    case 'no1':
      Get.to(() => CvInputNo1(), arguments: {'type': typeCv, 'option': option});
      break;
    case 'no2':
      Get.to(() => CvInputNo2(), arguments: {'type': typeCv, 'option': option});
      break;
    default:
      Get.snackbar("Error", "Unknown input type: $inputType");
  }
}
