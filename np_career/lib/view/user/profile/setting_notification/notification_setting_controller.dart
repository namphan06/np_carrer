import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingController extends GetxController {
  var receiveFromCompany = false.obs;
  var receiveMatchingJobs = false.obs;
  var receiveSimilarJobs = false.obs;

  Future<void> saveNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('receive_from_company', receiveFromCompany.value);
    await prefs.setBool('receive_matching_jobs', receiveMatchingJobs.value);
    await prefs.setBool('receive_similar_jobs', receiveSimilarJobs.value);
    print("Notification settings saved.");
  }

  Future<void> loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    receiveFromCompany.value = prefs.getBool('receive_from_company') ?? true;
    receiveMatchingJobs.value = prefs.getBool('receive_matching_jobs') ?? false;
    receiveSimilarJobs.value = prefs.getBool('receive_similar_jobs') ?? true;
    print("Notification settings loaded.");
  }

  @override
  void onClose() {
    super.onClose();
  }
}
