import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:np_career/company/application_apply/notification_setting/notification_application/notification_application.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/job_applied/job_applied.dart';

class NotificationSettingApply extends StatefulWidget {
  const NotificationSettingApply({super.key});

  @override
  State<NotificationSettingApply> createState() =>
      _NotificationSettingApplyState();
}

class _NotificationSettingApplyState extends State<NotificationSettingApply> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'type': 'Reply to Job Application ',
        'action': () => Get.to(NotificationApplication())
      },
      {'type': 'Other ', 'action': () => Get.snackbar("Test", "Test action")},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Notification Setting",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F6F8),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final item = actions[index];
          return InkWell(
            onTap: item['action'],
            borderRadius: BorderRadius.circular(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      item['type'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
