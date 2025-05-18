import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_controller.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_fb.dart';
import 'package:np_career/core/app_color.dart';

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
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Interview Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Buttons
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceChip(
                          label: const Text('Show All'),
                          selected: controller.isAllScheduleSelected.value,
                          onSelected: (selected) {
                            controller.isAllScheduleSelected.value = true;
                          },
                          selectedColor: AppColor.greenPrimaryColor,
                          labelStyle: TextStyle(
                              color: controller.isAllScheduleSelected.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        ChoiceChip(
                          label: const Text('By Date'),
                          selected: !controller.isAllScheduleSelected.value,
                          onSelected: (selected) {
                            controller.isAllScheduleSelected.value = false;
                          },
                          selectedColor: AppColor.greenPrimaryColor,
                          labelStyle: TextStyle(
                              color: !controller.isAllScheduleSelected.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 12),

            // Date Picker Button
            Obx(() => controller.isAllScheduleSelected.value
                ? const SizedBox.shrink()
                : Center(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.selectDate(context),
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        controller.selectedDate.value == null
                            ? 'Pick a date'
                            : 'Date: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.greenPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  )),
            const SizedBox(height: 12),

            // Interview Schedule List
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
                          child: Text('An error occurred!',
                              style: TextStyle(color: Colors.red)));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    }

                    final listSchedule = snapshot.data!;

                    return ListView.builder(
                      itemCount: listSchedule.length,
                      itemBuilder: (context, docIndex) {
                        final docData = listSchedule[docIndex];
                        final docId = docData['docId'] ?? '';
                        final schedules =
                            (docData['list_schedule'] as List?) ?? [];

                        if (schedules.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('No schedules on date $docId'),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Date Interview: $docId',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            ...schedules.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item =
                                  entry.value as Map<String, dynamic>? ?? {};
                              final jobName = item['jobName'] ?? 'No job name';
                              final cvList = (item['listCv'] as List?) ?? [];

                              // Đặt biến isExpanded bên ngoài Obx tránh lỗi
                              bool isExpanded =
                                  controller.expandedCards.contains(docIndex);

                              return Obx(() {
                                // Dùng Obx chỉ để lắng nghe expandedCards thay đổi
                                isExpanded =
                                    controller.expandedCards.contains(docIndex);
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
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
                                              color:
                                                  AppColor.greenPrimaryColor),
                                        ),
                                        trailing: Icon(isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down),
                                        onTap: () {
                                          if (isExpanded) {
                                            controller.expandedCards
                                                .remove(docIndex);
                                          } else {
                                            controller.expandedCards
                                                .add(docIndex);
                                          }
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
                                              return InkWell(
                                                onTap: () => controller.getCv(
                                                    cv['idCv'], cv['type']),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.person,
                                                          color: AppColor
                                                              .greenPrimaryColor),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          '${cv['userName'] ?? 'No name'} (${cv['type'] ?? 'Unknown'})',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        crossFadeState: isExpanded
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }).toList(),
                          ],
                        );
                      },
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
