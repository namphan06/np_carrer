import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/tool/mi/mi_answere.dart';
import 'mi_controller.dart';

class Mi extends StatelessWidget {
  Mi({Key? key}) : super(key: key);

  final MiController controller = Get.put(MiController());

  final Map<int, String> answerLabels = {
    1: 'Hoàn toàn sai',
    2: 'Thường là sai',
    3: 'Không rõ ràng',
    4: 'Đôi lúc đúng',
    5: 'Hoàn toàn đúng',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question MI')),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Giải thích đáp án 1 lần ở đầu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: answerLabels.entries.map((e) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${e.key}: ${e.value}',
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Danh sách câu hỏi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  final question = controller.questions[index];
                  final selectedAnswer =
                      controller.answers[index]['answer'] as int;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: selectedAnswer == 0
                            ? Colors.grey
                            : AppColor.greenPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: List.generate(5, (i) {
                              final answerValue = i + 1;
                              final isSelected = selectedAnswer == answerValue;

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.selectAnswer(index, answerValue);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColor.greenPrimaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColor.greenPrimaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$answerValue',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Nút Submit
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: controller.isAllAnswered
                    ? () {
                        print('Answers: ${controller.answers}');
                        Get.to(MiResultScreen(answers: controller.answers));
                      }
                    : null,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
