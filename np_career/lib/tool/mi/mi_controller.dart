// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:np_career/tool/courses/providers/MIProvider.dart';

// class MiController extends GetxController {
//   final FirebaseFirestore _fb = FirebaseFirestore.instance;

//   var questions = <Map<String, dynamic>>[].obs;
//   var answers = <Map<String, dynamic>>[].obs; // {answer: int, type: string}

//   // final MiProvider miProvider;

//   // Thêm constructor để nhận MiProvider
//   // MiController({required this.miProvider});

//   @override
//   void onInit() {
//     super.onInit();
//     // Có thể gọi luôn loadQuestionsFromProvider ở đây
//     // loadQuestionsFromProvider();
//   }

//   // void loadQuestionsFromProvider() {
//   //   final misList = miProvider.mis;

//   //   if (misList.isNotEmpty) {
//   //     questions.value = misList
//   //         .map((mi) => {
//   //               'id': mi.id,
//   //               'title': mi.title,
//   //               'type': mi.type,
//   //             })
//   //         .toList();

//   //     answers.value =
//   //         questions.map((q) => {'answer': 0, 'type': q['type'] ?? ''}).toList();
//   //   } else {
//   //     // Đẩy việc show snackbar vào callback sau frame dựng xong
//   //     WidgetsBinding.instance.addPostFrameCallback((_) {
//   //       Get.snackbar('Lỗi', 'Danh sách Mi trống.');
//   //     });
//   //   }
//   // }

//   void selectAnswer(int index, int answerValue) {
//     answers[index] = {
//       'answer': answerValue,
//       'type': questions[index]['type'] ?? ''
//     };
//     answers.refresh();
//   }

//   bool get isAllAnswered => !answers.any((a) => a['answer'] == 0);
// }

// // void loadQuestionsFromFirebase() async {
//   //   try {
//   //     final snapshot = await _fb.collection('qs_mi').doc('qs1').get();

//   //     if (snapshot.exists) {
//   //       // Lấy danh sách câu hỏi trong field 'question' (dạng List<dynamic>)
//   //       final data = snapshot.data();
//   //       final List<dynamic> qs = data?['question'] ?? [];

//   //       questions.value = qs.cast<Map<String, dynamic>>();

//   //       // Khởi tạo answers với answer=0 (chưa chọn), lưu type tương ứng
//   //       answers.value = questions
//   //           .map((q) => {'answer': 0, 'type': q['type'] ?? ''})
//   //           .toList();
//   //     }
//   //   } catch (e) {
//   //     Get.snackbar('Error', 'Không tải được câu hỏi: $e');
//   //   }
//   // }

import 'package:get/get.dart';

class MiController extends GetxController {
  var answers = <Map<String, dynamic>>[].obs; // List chứa {answer, type}

  void initAnswers(int length, List<String> types) {
    answers.value = List.generate(
        length,
        (index) => {
              'answer': 0,
              'type': types[index],
            });
  }

  void selectAnswer(int index, int answerValue) {
    answers[index] = {
      'answer': answerValue,
      'type': answers[index]['type'] ?? '',
    };
    answers.refresh();
  }

  bool get isAllAnswered => !answers.any((a) => a['answer'] == 0);
}
