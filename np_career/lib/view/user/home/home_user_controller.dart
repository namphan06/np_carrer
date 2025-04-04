import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';

class HomeUserController extends GetxController {
  var nameController = "".obs;
  var emailController = "".obs;

  final LoginFb _loginFb = Get.put(LoginFb());

  @override
  void onInit() {
    getUser();
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
}
