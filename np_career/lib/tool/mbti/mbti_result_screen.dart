import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class MbtiResultScreen extends StatelessWidget {
  final String result;

  const MbtiResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(" MBTI Result"),
        backgroundColor: AppColor.orangePrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.person_pin,
                        color: AppColor.greenPrimaryColor, size: 28),
                    SizedBox(width: 10),
                    Text(
                      "Your Personality Analysis",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.greenPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      result,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
