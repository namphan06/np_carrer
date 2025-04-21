import 'package:get/get.dart';
import 'package:np_career/company/profile_company/profile_company.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_screen.dart';

class ProfileController extends GetxController {
  var nameController = "".obs;
  var roleController = "".obs;

  final LoginFb _loginFb = Get.find<LoginFb>();

  @override
  void onInit() {
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

  void handleMyProfile() {
    if (roleController.value == 'user') {
      Get.to(MyProfileScreen());
    } else if (roleController.value == 'company') {
      Get.to(ProfileCompany());
    } else {
      Get.snackbar("Error", 'Don\'t have role');
    }
  }
}
