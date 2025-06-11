import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';

class PolicyDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const PolicyDetailScreen({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header đẹp hơn
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.orangePrimaryColor.withOpacity(0.9),
                      AppColor.orangePrimaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 40), // Để giữ tiêu đề căn giữa
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Nội dung cuộn
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16, height: 1.7),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.lightBackgroundColor,
    );
  }
}
