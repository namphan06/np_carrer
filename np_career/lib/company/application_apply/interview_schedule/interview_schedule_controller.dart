import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class InterviewScheduleController extends GetxController {
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxBool isAllScheduleSelected = true.obs;
  final RxSet<int> expandedCards = <int>{}.obs;

  // Hàm hiển thị chọn ngày
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }
}
