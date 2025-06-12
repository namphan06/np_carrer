// guide_list_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/hiring/guid_data.dart';

import 'package:np_career/company/hiring/guide_detail_screen.dart';
import 'package:np_career/core/app_color.dart';

class GuideListScreen extends StatelessWidget {
  const GuideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guideData = GuidData().guideData; // Danh sách dữ liệu

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Guides for Employers",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColor.lightBackgroundColor,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: guideData.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: AppColor.orangePrimaryColor.withOpacity(0.1),
                child:
                    Icon(Icons.menu_book, color: AppColor.orangePrimaryColor),
              ),
              title: Text(
                guideData[index]['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GuideDetailScreen(
                      title: guideData[index]['title']!,
                      content: guideData[index]['content']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
