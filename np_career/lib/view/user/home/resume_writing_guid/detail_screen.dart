import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';

class DetailScreen extends StatefulWidget {
  final List<Map<String, String>> data;
  const DetailScreen({super.key, required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
            "Detail List",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: widget.data.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(widget.data[index]['title']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
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
