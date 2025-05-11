import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:np_career/cv_template/cv1/cv1.dart';
import 'package:np_career/view/screen/home.dart';
import 'package:np_career/view/user/job_applied/job_applied.dart';

enum EnumCvNo1 {
  cv1_no1(
      "CV1", ["Experience", "Two Pages", "Viet Nam"], "style", "no1", _cv1_no1),
  // Test data
  cv2_no1("CV1", ["Basic 1", "Two Pages", "Viet Nam", "ENG"], "position", "no1",
      _cv2_no1),
  cv3_no1("CV1", ["Basic 2", "Two Pages", "Viet Nam", "DOC"], "position", "no1",
      _cv2_no1),
  cv4_no1("CV1", ["Basic 3", "Two Pages", "Viet Nam", "TEA"], "position", "no1",
      _cv2_no1),
  cv5_no1("CV1", ["Basic 4", "Two Pages", "Viet Nam", "LAW"], "position", "no1",
      _cv2_no1),
  cv6_no1("CV1", ["Basic 5", "Two Pages", "Viet Nam", "ARC"], "position", "no1",
      _cv2_no1);

  final String label;
  final List<String> tag;
  final String type;
  final String type_input;
  final Function() action;

  const EnumCvNo1(
      this.label, this.tag, this.type, this.type_input, this.action);

  void run() => action();
}

void _cv1_no1() {
  Get.to(Cv1());
}

void _cv2_no1() {
  Get.to(JobApplied());
}
