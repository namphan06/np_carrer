import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/tool/mbti/mbti_controller.dart';
import 'package:np_career/tool/courses/providers/MBTIProvider.dart';
import 'package:provider/provider.dart';

class MbtiScreen extends StatelessWidget {
  final MbtiController controller = Get.put(MbtiController());

  @override
  Widget build(BuildContext context) {
    return Consumer<MbtiQuestionProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.selectedAnswers.isEmpty) {
          controller.initSelection(provider.questions.length);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(" MBTI Test"),
            backgroundColor: AppColor.orangePrimaryColor,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: provider.questions.length,
            itemBuilder: (context, index) {
              final question = provider.questions[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q${index + 1}: ${question.content}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...question.answers.map((answer) {
                        return Obx(() => RadioListTile<String>(
                              title: Text(answer.content),
                              value: answer.content,
                              groupValue: controller.selectedAnswers[index],
                              onChanged: (val) {
                                controller.selectAnswer(index, val!);
                              },
                            ));
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.submitAnswers,
            label: const Text('Submit'),
            icon: const Icon(Icons.send),
          ),
        );
      },
    );
  }
}
