import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/home/resume_writing_guid/data_resume.dart';
import 'package:np_career/view/user/home/resume_writing_guid/detail_screen.dart';

class ResumeWritingGuid extends StatefulWidget {
  const ResumeWritingGuid({super.key});

  @override
  State<ResumeWritingGuid> createState() => _ResumeWritingGuidState();
}

class _ResumeWritingGuidState extends State<ResumeWritingGuid> {
  final data = DataResume();
  @override
  Widget build(BuildContext context) {
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
            "Resume Writing Guide",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: data.data1.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(data.data1[index]['title']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                final data2 = data.data2
                    .where((element) =>
                        element['code'] == data.data1[index]['code'])
                    .toList();

                Get.to(() => DetailScreen(data: data2));

                // Get.to(() => PolicyDetailScreen(
                //       title: policies[index],
                //       content: contents[index],
                //     ));
              },
            ),
          );
        },
      ),
    );
  }
}
