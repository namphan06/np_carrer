import 'dart:convert';
import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class EmailSettingController extends GetxController {
  final TextEditingController emailAcceptController = TextEditingController();
  final TextEditingController emailRejectController = TextEditingController();
  RxBool isFileSelected = false.obs;
  void disposeControllers() {
    emailAcceptController.dispose();
    emailRejectController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    loadEmails(); // Gọi hàm loadEmails khi controller được khởi tạo
  }

  Future<void> pickFileForAccept() async {
    await _pickAndReadFile(targetController: emailAcceptController);
  }

  Future<void> pickFileForReject() async {
    await _pickAndReadFile(targetController: emailRejectController);
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _pickAndReadFile(
      {required TextEditingController targetController}) async {
    if (!await requestStoragePermission()) {
      Get.snackbar(
        'Thông báo',
        'Bạn cần cấp quyền truy cập bộ nhớ!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final ext = p.extension(filePath).toLowerCase();
      String content = '';

      try {
        if (ext == '.txt') {
          content = await File(filePath).readAsString(encoding: utf8);
        } else if (ext == '.docx') {
          final fileBytes = await File(filePath).readAsBytes();
          content = await docxToText(fileBytes); // Hàm chuyển DOCX thành text
        } else {
          Get.snackbar('Lỗi', 'Không hỗ trợ định dạng này.');
          return;
        }

        targetController.text = content;
      } catch (e) {
        Get.snackbar('Lỗi', 'Không thể đọc file: $e');
      }
    } else {
      print("Không chọn file.");
    }
  }

  // Các hàm khác như saveEmails
  Future<void> saveEmails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lưu thông tin mới vào SharedPreferences
    await prefs.setString('emailAccept', emailAcceptController.text);
    await prefs.setString('emailReject', emailRejectController.text);

    // Hiển thị thông báo thành công
    Get.snackbar(
      'Success',
      'Email settings saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> loadEmails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy dữ liệu đã lưu trước đó
    String? savedEmailAccept = prefs.getString('emailAccept');
    String? savedEmailReject = prefs.getString('emailReject');

    // Nếu có dữ liệu đã lưu, hiển thị lên các trường TextField
    if (savedEmailAccept != null && savedEmailAccept.isNotEmpty) {
      emailAcceptController.text = savedEmailAccept;
    }
    if (savedEmailReject != null && savedEmailReject.isNotEmpty) {
      emailRejectController.text = savedEmailReject;
    }
  }
}
