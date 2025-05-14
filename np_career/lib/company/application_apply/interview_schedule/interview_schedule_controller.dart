import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_fb.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:path_provider/path_provider.dart';

class InterviewScheduleController extends GetxController {
  InterviewScheduleFb _fb = Get.put(InterviewScheduleFb());

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxBool isAllScheduleSelected = true.obs;
  final RxSet<int> expandedCards = <int>{}.obs;
  final GlobalKey repaintKey = GlobalKey();

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

  Future<void> getCv(String uid, String type) async {
    try {
      CvModel model = await _fb.getCvModel(uid, type);
      EnumCvOutput.cv1_no1.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  // Future<void> captureAndSave() async {
  //   try {
  //     // Tìm RenderObject từ GlobalKey
  //     RenderRepaintBoundary boundary = repaintKey.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     // Chụp ảnh
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData? byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();

  //     // Lưu ảnh vào bộ nhớ
  //     final directory = await getApplicationDocumentsDirectory();
  //     final filePath = '${directory.path}/captured_image.png';
  //     final file = File(filePath);
  //     await file.writeAsBytes(pngBytes);

  //     // Lưu vào thư viện ảnh
  //     await ImageGallerySaver.saveFile(filePath);
  //     print("Image saved to gallery");
  //   } catch (e) {
  //     print("Error capturing image: $e");
  //   }
  // }
}
