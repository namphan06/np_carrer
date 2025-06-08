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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Text(
          "Interview Schedule",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.orangePrimaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: AppColor.orangePrimaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Filter Interviews",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFilterChip(
                              'Show All',
                              controller.isAllScheduleSelected.value,
                              (selected) {
                                controller.isAllScheduleSelected.value = true;
                              },
                              Icons.list_alt,
                            ),
                            _buildFilterChip(
                              'By Date',
                              !controller.isAllScheduleSelected.value,
                              (selected) {
                                controller.isAllScheduleSelected.value = false;
                              },
                              Icons.calendar_today,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Date Picker Button
              Obx(() => controller.isAllScheduleSelected.value
                  ? const SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      child: _buildDatePickerButton(),
                    )),
              const SizedBox(height: 24),

              // Interview List Section
              Expanded(
                child: Obx(() {
                  final showAll = controller.isAllScheduleSelected.value;
                  final selectedDate = controller.selectedDate.value;
                  return StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _fb.getJobScheduleStream(showAll, selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildLoadingState();
                      }
                      if (snapshot.hasError) {
                        return _buildErrorState();
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildEmptyState();
                      }

                      return _buildInterviewList(snapshot.data!);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool isSelected,
    Function(bool) onSelected,
    IconData icon,
  ) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: AppColor.greenPrimaryColor,
      backgroundColor: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: isSelected ? 2 : 0,
    );
  }

  Widget _buildDatePickerButton() {
    return ElevatedButton.icon(
      onPressed: () => controller.selectDate(context),
      icon: const Icon(Icons.calendar_today_outlined, size: 20),
      label: Text(
        controller.selectedDate.value == null
            ? 'Select Interview Date'
            : DateFormat('MMMM dd, yyyy')
                .format(controller.selectedDate.value!),
        style: const TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.greenPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColor.orangePrimaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading schedules...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'An error occurred!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No interviews scheduled',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewList(List<Map<String, dynamic>> listSchedule) {
    return ListView.builder(
      itemCount: listSchedule.length,
      itemBuilder: (context, docIndex) {
        final docData = listSchedule[docIndex];
        final docId = docData['docId'] ?? '';
        final schedules = (docData['list_schedule'] as List?) ?? [];

        if (schedules.isEmpty) {
          return _buildEmptyDateCard(docId);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(docId),
            ...schedules
                .map((schedule) => _buildScheduleCard(schedule, docIndex))
                .toList(),
          ],
        );
      },
    );
  }

  Widget _buildEmptyDateCard(String docId) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No schedules on date $docId',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDateHeader(String docId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: [
          Icon(
            Icons.event,
            color: AppColor.orangePrimaryColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Date: $docId',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule, int docIndex) {
    final jobName = schedule['jobName'] ?? 'No job name';
    final cvList = (schedule['listCv'] as List?) ?? [];
    bool isExpanded = controller.expandedCards.contains(docIndex);

    return Obx(() {
      isExpanded = controller.expandedCards.contains(docIndex);
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Row(
                children: [
                  Icon(
                    Icons.work,
                    color: AppColor.greenPrimaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      jobName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: AppColor.greenPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColor.greenPrimaryColor,
                ),
              ),
              onTap: () {
                if (isExpanded) {
                  controller.expandedCards.remove(docIndex);
                } else {
                  controller.expandedCards.add(docIndex);
                }
              },
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: _buildCandidatesList(cvList),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCandidatesList(List cvList) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Candidates',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          ...cvList.map<Widget>((cv) => _buildCandidateItem(cv)).toList(),
        ],
      ),
    );
  }

  Widget _buildCandidateItem(Map<String, dynamic> cv) {
    return InkWell(
      onTap: () => controller.getCv(cv['idCv'], cv['type']),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.greenPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.person,
                color: AppColor.greenPrimaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cv['userName'] ?? 'No name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cv['type'] ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
