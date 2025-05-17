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

class NotificationApplicationController extends GetxController {
  final TextEditingController notificationAcceptController =
      TextEditingController();
  final TextEditingController notificationRejectController =
      TextEditingController();
  RxBool isFileSelected = false.obs;
  void disposeControllers() {
    notificationAcceptController.dispose();
    notificationRejectController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    loadEmails(); // Gọi hàm loadEmails khi controller được khởi tạo
  }

  Future<void> pickFileForAccept() async {
    await _pickAndReadFile(targetController: notificationAcceptController);
  }

  Future<void> pickFileForReject() async {
    await _pickAndReadFile(targetController: notificationRejectController);
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _pickAndReadFile(
      {required TextEditingController targetController}) async {
    if (!await requestStoragePermission()) {
      Get.snackbar(
        'Error',
        'There is no access',
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
          Get.snackbar('Error', 'No format support.');
          return;
        }

        targetController.text = content;
      } catch (e) {
        Get.snackbar('Error', 'Can not read the file: $e');
      }
    } else {
      print("No file.");
    }
  }

  // Các hàm khác như saveEmails
  Future<void> saveEmails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lưu thông tin mới vào SharedPreferences
    await prefs.setString(
        'notificationAccept', notificationAcceptController.text);
    await prefs.setString(
        'notificationReject', notificationRejectController.text);

    // Hiển thị thông báo thành công
    Get.snackbar(
      'Success',
      'Notification settings saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> loadEmails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy dữ liệu đã lưu trước đó
    String? savedNotificationAccept = prefs.getString('notificationAccept');
    String? savedNotificationReject = prefs.getString('notificationReject');

    // Nếu có dữ liệu đã lưu, hiển thị lên các trường TextField
    if (savedNotificationAccept != null && savedNotificationAccept.isNotEmpty) {
      notificationAcceptController.text = savedNotificationAccept;
    }
    if (savedNotificationReject != null && savedNotificationReject.isNotEmpty) {
      notificationRejectController.text = savedNotificationReject;
    }
  }
}
