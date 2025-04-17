import 'package:get/get.dart';
import 'package:np_career/view/user/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký controller cho route này
    Get.put(ProfileController());
  }
}
