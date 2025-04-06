import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:np_career/view/screen/home.dart';

enum EnumCvNo1 {
  cv1_no1("cv1_no1", _cv1_no1);

  final String label;
  final Function() action;

  const EnumCvNo1(this.label, this.action);

  void run() => action();
}

void _cv1_no1() {
  Get.to(Home());
}
