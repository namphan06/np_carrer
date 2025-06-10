import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/tool/courses/providers/MIProvider.dart';
import 'package:np_career/tool/mi/mi_answere.dart';
import 'mi_controller.dart';

class Mi extends StatefulWidget {
  const Mi({Key? key}) : super(key: key);

  @override
  State<Mi> createState() => _MiState();
}

class _MiState extends State<Mi> {
  final Map<int, String> answerLabels = {
    1: 'Hoàn toàn sai',
    2: 'Thường là sai',
    3: 'Không rõ ràng',
    4: 'Đôi lúc đúng',
    5: 'Hoàn toàn đúng',
  };

  // late MiController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = Get.put(MiController());
  // }
  MiController controller = Get.put(MiController());

  @override
  Widget build(BuildContext context) {
    final miProvider = Provider.of<MiProvider>(context);

    if (miProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Khởi tạo answers nếu chưa khởi tạo hoặc số câu hỏi thay đổi
    if (controller.answers.length != miProvider.mis.length) {
      controller.initAnswers(
        miProvider.mis.length,
        miProvider.mis.map((e) => e.type ?? '').toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Question MI'),
        centerTitle: true,
        backgroundColor: AppColor.orangePrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Giải thích đáp án
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
              itemCount: miProvider.mis.length,
              itemBuilder: (context, index) {
                final question = miProvider.mis[index].title ?? '';
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
                          question,
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
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
                        ),
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
            child: Obx(() {
              return ElevatedButton(
                onPressed: controller.isAllAnswered
                    ? () {
                        print('Answers: ${controller.answers}');
                        Get.to(
                            () => MiResultScreen(answers: controller.answers));
                      }
                    : null,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
