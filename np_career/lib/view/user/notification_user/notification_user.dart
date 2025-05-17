import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/notification_user/notification_user_fb.dart';
import 'package:intl/intl.dart'; // để định dạng timestamp

class NotificationUser extends StatelessWidget {
  NotificationUser({super.key});

  final NotificationUserFb fb = Get.put(NotificationUserFb());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios, color: AppColor.lightBackgroundColor),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: fb.getNotification(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null || data['notifications'] == null) {
            return const Center(child: Text('No notifications found.'));
          }

          final List notifications = data['notifications'];

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              final text = notif['text'] ?? '';
              final lines = text.split('\n');
              final firstLine = lines.isNotEmpty ? lines[0] : '';
              final status = notif['status'] ?? false;

              // Format timestamp (nếu có)
              String formattedTime = '';
              if (notif['timestamp'] != null) {
                final ts = notif['timestamp'] as Timestamp;
                final dateTime = ts.toDate();
                formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
              }

              return InkWell(
                onTap: () {
                  fb.markNotificationAsRead(index);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Notification"),
                      content: Text(text),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: status ? Colors.green : Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstLine,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (formattedTime.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
