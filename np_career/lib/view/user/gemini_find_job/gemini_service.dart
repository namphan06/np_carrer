import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/api_key.dart';
import 'package:np_career/view/user/profile/gemini_chat/gemini_chat_service.dart';
import 'package:np_career/model/job_post_model.dart'; // Giả sử bạn có model này

class GeminiService extends GetxController {
  final textController = TextEditingController();
  final RxList<String> messages = <String>[].obs;
  final RxList<JobPostModel> matchingJobs = <JobPostModel>[].obs;
  final RxBool isLoading = false.obs;

  late final GeminiChatService _chatService;

  @override
  void onInit() {
    super.onInit();
    _chatService =
        GeminiChatService(geminiApiKey1); // Thay bằng API key của bạn
  }

  Future<List<JobPostModel>> fetchAllJobs() async {
    final snapshot = await FirebaseFirestore.instance.collection('jobs').get();
    return snapshot.docs
        .map((doc) => JobPostModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> searchJobsWithChat() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    messages.add("[User] $text");
    textController.clear();

    isLoading.value = true;
    matchingJobs.clear();

    final jobs = await fetchAllJobs();

    for (final job in jobs) {
      final prompt = '''
User's Query: "$text"

You are an intelligent assistant helping users find suitable jobs.

Please analyze the user's query and check if it matches the job's information below. Match based on semantic similarity, not just exact words.

Instructions:
- If the query mentions things like **"phúc lợi", "quyền lợi", "lương thưởng", "bảo hiểm"**, then compare with the **Benefits** section.
- If the query includes words like **"yêu cầu", "trình độ", "bằng cấp", "kỹ năng"**, then check the **Required Qualifications**.
- If the query talks about **vị trí, mô tả, nhiệm vụ, công việc cụ thể**, use the **Job Description**.
- Always consider **related meanings**, not just exact matches.
- Only reply `"yes"` if the job information fits well with the user’s query in terms of meaning and intent.
- Otherwise, reply `"no"`.

Job Information:
- Title: ${job.name}
- City: ${job.city.join(', ')}
- Salary: ${job.minSalary}-${job.maxSalary} ${job.currencyUnit}
- Experience: ${job.experience}
- Working Time: ${job.timeWork}
- Deadline: ${job.applicationDeadline}
- Work Location: ${job.workLocation.join(', ')}

Job Description:
${job.jobDescription.join('\n')}

Required Qualifications:
${job.requiredApplication.join('\n')}

Benefits:
${job.benefits.join('\n')}

Question: Is this job suitable for the query?
Reply only "yes" or "no".
''';

      final response = await _chatService.sendMessage(prompt);
      final answer = response.toLowerCase().trim();

      messages.add("Job: ${job.name} → $answer");

      if (answer.contains("yes")) {
        matchingJobs.add(job);
      }
    }

    isLoading.value = false;

    if (matchingJobs.isNotEmpty) {
      messages.add("Found ${matchingJobs.length} matching job(s).");
    } else {
      messages.add("No matching jobs found.");
    }
  }

  Future<bool> isSavedJob(String jobId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('user_actions')
        .doc(userId)
        .get();

    final data = doc.data();
    if (data == null || data['saves'] == null) return false;

    final saves = List<String>.from(data['saves']);
    return saves.contains(jobId);
  }
}
