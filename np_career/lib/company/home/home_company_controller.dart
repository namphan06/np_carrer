import 'package:get/get.dart';
import 'package:np_career/company/create_job_post/create_job_post.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login_fb.dart';
import 'package:np_career/view/screen/home.dart';

class HomeCompanyController extends GetxController {
  var nameController = "".obs;
  var emailController = "".obs;

  List<Map<String, dynamic>> get items => [
        {
          'img':
              'assets/images/work_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Create Job Post',
          'onTap': () => Get.to(CreateJobPost(
                nameCompany: nameController.value,
              ))
        },
        {
          'img':
              'assets/images/assignment_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Hiring Information',
          'onTap': () => Get.to(Home())
        },
        {
          'img':
              'assets/images/article_person_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Job Application CV',
          'onTap': () => Get.to(Home())
        },
        {
          'img':
              'assets/images/groups_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Followers',
          'onTap': () => Get.to(Home())
        },
        {
          'img':
              'assets/images/recommend_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Recommended CV',
          'onTap': () => Get.to(Home())
        },
        {
          'img':
              'assets/images/analytics_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg',
          'text': 'Analytics',
          'onTap': () => Get.to(Home())
        }
      ];

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
