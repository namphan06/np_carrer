import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/api_key.dart';
import 'package:np_career/tool/mbti/gemini_mbti.dart';
import 'package:np_career/tool/mbti/mbti_result_screen.dart';

class MbtiController extends GetxController {
  var selectedAnswers = <String?>[].obs;

  void initSelection(int count) {
    selectedAnswers.value = List<String?>.filled(count, null);
  }

  void selectAnswer(int index, String answerContent) {
    selectedAnswers[index] = answerContent;
  }

  void submitAnswers() async {
    final selected = selectedAnswers.whereType<String>().toList();

    final gemini = GeminiMbtiService(apiKey: geminiApiKey1);
    final result = await gemini.analyzeMbti(selected);

    Get.to(() => MbtiResultScreen(result: result));
  }
}
