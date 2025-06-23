import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:np_career/api_key.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:np_career/view/user/job/chat_interview/result_screen.dart';
import 'package:np_career/view/user/profile/gemini_chat/gemini_chat_service.dart';

class InterviewController extends GetxController {
  late final GeminiChatService _chatService;

  var currentQuestion = "".obs;
  var currentAnswer = "".obs;
  var answers = <String>[].obs;
  var questions = <String>[].obs;
  var feedback = "".obs;
  var showQuestion = false.obs;

  Future<JobPostModel> fetchAllJobs() async {
    final uid = Get.arguments['uid'];
    final doc =
        await FirebaseFirestore.instance.collection('jobs').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return JobPostModel.fromMap(doc.data()!);
    } else {
      throw Exception('Job not found');
    }
  }

  @override
  void onReady() {
    super.onReady();
    _chatService = GeminiChatService(geminiApiKey1);
    _generateQuestions();
  }

  void _generateQuestions() async {
    final job = await fetchAllJobs();
    final prompt = '''
I am applying for a job with the following information:
- Title: ${job.name}
- City: ${job.city.join(', ')}
- Salary: ${job.minSalary}-${job.maxSalary} ${job.currencyUnit}
- Experience: ${job.experience}
- Working Time: ${job.timeWork}
- Deadline: ${job.applicationDeadline}
- Work Location: ${job.workLocation.join(', ')}

Please provide 10 suitable interview questions.
''';

    final response = await _chatService.sendMessage(prompt);

    final questionList =
        response.split('\n').where((e) => e.trim().isNotEmpty).toList();

    if (questionList.isNotEmpty) {
      questions.assignAll(questionList);
      currentQuestion.value = questions.first;
      showQuestion.value = true;
    }
  }

  void nextQuestion(String answer) {
    answers.add(answer);
    if (answers.length < questions.length) {
      currentQuestion.value = questions[answers.length];
      print('Current Question: ${currentQuestion.value}');
    } else {
      generateFeedback();
      Get.to(() => ResultScreen());
    }
  }

  void generateFeedback() async {
    final prompt = '''
Below are the interview questions and the candidate's answers:

${List.generate(questions.length, (i) => 'Question ${i + 1}: ${questions[i]}\nAnswer: ${answers[i]}\n').join()}

Please provide feedback and suggestions for improvement.
''';

    feedback.value = await _chatService.sendMessage(prompt);
  }
}
