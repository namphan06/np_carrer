import 'package:get/get.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';

class ProfileController extends GetxController {
  var nameController = "".obs;
  var roleController = "".obs;

  final LoginFb _loginFb = Get.put(LoginFb());
  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      UserModel userModel = await _loginFb.getUser();
      nameController.value = userModel.username;
      roleController.value = userModel.role;
    } catch (err) {
      Get.snackbar("Error", "Fail get user detail");
    }
  }
}
