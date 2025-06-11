import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/login/login.dart';
import 'package:np_career/view/login/login_fb.dart';
import 'package:np_career/view/user/profile/change_password/change_password_screen.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_screen.dart';
import 'package:np_career/view/user/profile/policy/policy_home_page.dart';
import 'package:np_career/view/user/profile/profile_controller.dart';
import 'package:np_career/view/user/profile/setting_notification/notification_setting.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final LoginFb _loginFb = Get.find<LoginFb>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(35),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        border: Border.all(
                            color: AppColor.greenPrimaryColor, width: 3)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/images/profile-round-1342-svgrepo-com.svg',
                        height: 10,
                        width: 10,
                        color: AppColor.greenPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileController.nameController.value,
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Role : ${profileController.roleController.value}",
                          style: TextStyle(
                              color: AppColor.greenPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildContainer(
                "assets/images/account_circle_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "assets/images/keyboard_arrow_right_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "My profile",
                profileController.handleMyProfile),
            SizedBox(
              height: 15,
            ),
            _buildContainer(
                "assets/images/notifications_active.svg",
                "assets/images/keyboard_arrow_right_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "Notification setting",
                () => Get.to(NotificationSetting())),
            SizedBox(
              height: 15,
            ),
            _buildContainer(
                "assets/images/verified_user_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "assets/images/keyboard_arrow_right_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "Policy & Privacy",
                () => Get.to(PolicyHomePage())),
            SizedBox(
              height: 15,
            ),
            _buildContainer(
                "assets/images/lock_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "assets/images/keyboard_arrow_right_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                "Change password",
                () => Get.to(ChangePasswordScreen())),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Version : 1.0.0",
                style:
                    TextStyle(color: AppColor.greenPrimaryColor, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                _loginFb.signOut();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColor.greenPrimaryColor, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Text(
                  "Log out",
                  style: TextStyle(
                      color: AppColor.orangeRedColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(
      String prefixImage, String suffixImage, String title, Function() action) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.greenPrimaryColor, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: AppColor.orangePrimaryColor.withOpacity(0.66)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                prefixImage,
                width: 40,
                height: 40,
                color: AppColor.greenPrimaryColor,
              ),
              Text(
                title,
                style:
                    TextStyle(color: AppColor.greenPrimaryColor, fontSize: 30),
              ),
              SvgPicture.asset(
                suffixImage,
                width: 40,
                height: 40,
                color: AppColor.greenPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
