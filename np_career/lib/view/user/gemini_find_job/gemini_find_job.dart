import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/user/gemini_find_job/gemini_service.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_screen.dart';
import 'package:np_career/model/job_post_model.dart';

class GeminiFindJob extends StatelessWidget {
  const GeminiFindJob({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GeminiService());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back(result: true);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Smart Job Finder",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Obx(() => ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    ...controller.messages.map((msg) {
                      final isUser = msg.startsWith('[User]');
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg.replaceFirst(RegExp(r'^\[User\] '), ''),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Danh sách công việc
                    const Text(
                      "Recommended Jobs:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    Obx(() => Column(
                          children: controller.matchingJobs.map((job) {
                            return Card(
                              child: ListTile(
                                  title: Text(job.name),
                                  subtitle: Text(
                                      "${job.city.join(', ')} | ${job.minSalary}-${job.maxSalary} ${job.currencyUnit}"),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () async {
                                    final isSaved =
                                        await controller.isSavedJob(job.id);
                                    Get.to(() => JobDetailScreen(
                                          job: job,
                                          isSave: isSaved,
                                          companyId: job.id,
                                        ));
                                  }),
                            );
                          }).toList(),
                        )),
                  ],
                )),
          ),

          // Loading indicator
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink()),

          // Text input
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: 'Ví dụ: Tìm việc IT Helpdesk ở Hà Nội',
                    ),
                    onSubmitted: (_) => controller.searchJobsWithChat(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: controller.searchJobsWithChat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
