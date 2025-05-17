import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';

class HomeUserController extends GetxController {
  var nameController = "".obs;
  var emailController = "".obs;
  var unreadCount = 0.obs;

  final LoginFb _loginFb = Get.find<LoginFb>();

  @override
  void onInit() {
    getUser();
    countUnreadNotifications();
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      UserModel userModel = await _loginFb.getUser();
      nameController.value = userModel.username;
      emailController.value = userModel.email;
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> countUnreadNotifications() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('notification')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final data = snapshot.data();
    if (data == null || data['notifications'] == null) {
      unreadCount.value = 0;
      return;
    }

    final List notifications = data['notifications'];
    unreadCount.value = notifications.where((n) => n['status'] == false).length;
  }
}
