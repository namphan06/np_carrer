import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class GuideDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const GuideDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final steps = content.trim().split('\n');

    return Scaffold(
      backgroundColor: AppColor.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.green),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    steps[index],
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
