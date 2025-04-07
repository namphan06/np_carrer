import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:np_career/cv_template/cv1.dart';
import 'package:np_career/view/screen/home.dart';

enum EnumCvNo1 {
  cv1_no1("CV1", ["Experience", "Two Pages", "Viet Nam"], _cv1_no1);

  final String label;
  final List<String> tag;
  final Function() action;

  const EnumCvNo1(this.label, this.tag, this.action);

  void run() => action();
}

void _cv1_no1() {
  Get.to(Cv1());
}
