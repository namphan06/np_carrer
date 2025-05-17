import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/animation/animation_button_check.dart';
import 'package:np_career/view/user/profile/setting_notification/notification_setting_controller.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

NotificationSettingController controller =
    Get.put(NotificationSettingController());

class _NotificationSettingState extends State<NotificationSetting> {
  Widget buildToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required RxBool value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.orangePrimaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Obx(() => AnimationButtonCheck(
                  value: value.value,
                  onChanged: (val) {
                    value.value = val;
                    controller.saveNotificationSettings();
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadNotificationSettings();

    return Scaffold(
      backgroundColor: AppColor.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios, color: AppColor.lightBackgroundColor),
        ),
        title: Text(
          "Notification Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24, top: 16),
        children: [
          buildToggle(
            icon: Icons.business,
            title: "From Company",
            subtitle: "Get updates from the company directly.",
            value: controller.receiveFromCompany,
          ),
          buildToggle(
            icon: Icons.work,
            title: "Matching Jobs",
            subtitle: "Jobs that fit your profile and preferences.",
            value: controller.receiveMatchingJobs,
          ),
          buildToggle(
            icon: Icons.recommend,
            title: "Similar Jobs",
            subtitle: "Jobs similar to those you applied for.",
            value: controller.receiveSimilarJobs,
          ),
        ],
      ),
    );
  }
}
