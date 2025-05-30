import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MiController extends GetxController {
  final FirebaseFirestore _fb = FirebaseFirestore.instance;

  var questions = <Map<String, dynamic>>[].obs;
  var answers = <Map<String, dynamic>>[].obs; // {answer: int, type: string}

  @override
  void onInit() {
    super.onInit();
    loadQuestionsFromFirebase();
  }

  void loadQuestionsFromFirebase() async {
    try {
      final snapshot = await _fb.collection('qs_mi').doc('qs1').get();

      if (snapshot.exists) {
        // Lấy danh sách câu hỏi trong field 'question' (dạng List<dynamic>)
        final data = snapshot.data();
        final List<dynamic> qs = data?['question'] ?? [];

        questions.value = qs.cast<Map<String, dynamic>>();

        // Khởi tạo answers với answer=0 (chưa chọn), lưu type tương ứng
        answers.value = questions
            .map((q) => {'answer': 0, 'type': q['type'] ?? ''})
            .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Không tải được câu hỏi: $e');
    }
  }

  void selectAnswer(int index, int answerValue) {
    answers[index] = {
      'answer': answerValue,
      'type': questions[index]['type'] ?? ''
    };
    answers.refresh();
  }

  bool get isAllAnswered => !answers.any((a) => a['answer'] == 0);
}
