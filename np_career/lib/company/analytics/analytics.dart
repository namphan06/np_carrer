import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/company/analytics/analytics_fb.dart';
import 'package:np_career/core/app_color.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = AnalyticsFb();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Text(
          "Recruitment Statistics",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, int>>(
        stream: fb.statsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.orangePrimaryColor,
              ),
            );
          }

          final data = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.orangePrimaryColor.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.1,
                      children: [
                        _buildStatCard(
                          title: "Job Posts",
                          value: data['posts'].toString(),
                          icon: Icons.work_outline,
                          subtitle: "Posted so far",
                          bgColor: const Color(0xFFE3F2FD),
                          iconColor: Colors.blue,
                        ),
                        _buildStatCard(
                          title: "Applicants",
                          value: data['applicants'].toString(),
                          icon: Icons.group_outlined,
                          subtitle: "Total applied",
                          bgColor: const Color(0xFFFFF3E0),
                          iconColor: Colors.orange,
                        ),
                        _buildStatCard(
                          title: "Accepted",
                          value: data['accepted'].toString(),
                          icon: Icons.check_circle_outline,
                          subtitle: "You accepted",
                          bgColor: const Color(0xFFE8F5E9),
                          iconColor: Colors.green,
                        ),
                        _buildStatCard(
                          title: "Rejected",
                          value: data['rejected'].toString(),
                          icon: Icons.cancel_outlined,
                          subtitle: "You rejected",
                          bgColor: const Color(0xFFFFEBEE),
                          iconColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required String subtitle,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
