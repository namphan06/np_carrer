import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ResumeByStyleController extends GetxController {
  var selectChoice = "style".obs;
  var selectLanguageAndDesign = "".obs;
  var selectedLanguage = "Viet Nam".obs;
  var selectedDesign = "All designs".obs;

  void changeSelectChoice(String choice) {
    selectChoice.value = choice;
  }

  void changSelectLanguageAndDesign(String choice) {
    selectLanguageAndDesign.value = choice;
  }
}
