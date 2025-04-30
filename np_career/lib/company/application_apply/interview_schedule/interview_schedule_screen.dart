import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_controller.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_fb.dart';

class InterviewScheduleScreen extends StatefulWidget {
  const InterviewScheduleScreen({super.key});

  @override
  State<InterviewScheduleScreen> createState() =>
      _InterviewScheduleScreenState();
}

class _InterviewScheduleScreenState extends State<InterviewScheduleScreen> {
  final controller = Get.put(InterviewScheduleController());
  final _fb = Get.put(InterviewScheduleFb());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch Phỏng Vấn"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Toggle Buttons
          Obx(() => ToggleButtons(
                borderRadius: BorderRadius.circular(10),
                isSelected: [
                  controller.isAllScheduleSelected.value,
                  !controller.isAllScheduleSelected.value
                ],
                onPressed: (int index) {
                  controller.isAllScheduleSelected.value = index == 0;
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Hiển thị tất cả'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Theo ngày'),
                  ),
                ],
              )),
          const SizedBox(height: 10),
          // Date Picker
          Obx(() => controller.isAllScheduleSelected.value
              ? const SizedBox.shrink()
              : ElevatedButton.icon(
                  onPressed: () => controller.selectDate(context),
                  icon: const Icon(Icons.date_range),
                  label: Text(controller.selectedDate.value == null
                      ? 'Chọn ngày'
                      : 'Ngày: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!)}'),
                )),
          const SizedBox(height: 10),
          // Data List
          Expanded(
            child: Obx(() {
              final showAll = controller.isAllScheduleSelected.value;
              final selectedDate = controller.selectedDate.value;
              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: _fb.getJobScheduleStream(showAll, selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Có lỗi xảy ra!',
                            style: TextStyle(color: Colors.red)));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có dữ liệu'));
                  }

                  final listSchedule = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: listSchedule.length,
                    itemBuilder: (context, index) {
                      final item = listSchedule[index];
                      final jobName =
                          item['jobName'] ?? 'Không có tên công việc';
                      final cvList = item['listCv'] ?? [];

                      return Obx(() {
                        final isExpanded =
                            controller.expandedCards.contains(index);

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  jobName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                ),
                                trailing: Icon(isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down),
                                onTap: () {
                                  isExpanded
                                      ? controller.expandedCards.remove(index)
                                      : controller.expandedCards.add(index);
                                },
                              ),
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: cvList.map<Widget>((cv) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.person,
                                                color: Colors.blueAccent),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                '${cv['userName']} (${cv['type']})',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
