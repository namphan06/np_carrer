import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:np_career/company/profile_company/profile_company_fb.dart';
import 'package:np_career/model/profile_company_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:docx_to_text/docx_to_text.dart';

class ProfileCompanyController extends GetxController {
  final ProfileCompanyFb _fb = Get.put(ProfileCompanyFb());
  var mode = 'manual'.obs; // 'manual' or 'file'
  var inputText = ''.obs; // Lưu trữ nội dung trích xuất từ file

  TextEditingController websiteController = TextEditingController();
  TextEditingController headcountController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();

  var profileData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    final doc = await _fb.getProfileCompany();

    if (doc == null) {
      profileData.value = doc!;
    }
  }

  // Chuyển đổi giữa chế độ nhập thủ công và chọn file
  void switchMode(String selected) {
    mode.value = selected;
  }

  // Yêu cầu quyền truy cập bộ nhớ
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> pickAndReadFile() async {
    if (!await requestStoragePermission()) {
      print("Không được cấp quyền truy cập bộ nhớ.");
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

      if (ext == '.txt') {
        try {
          // Đọc file với mã hóa UTF-8 (có thể thay bằng mã hóa khác nếu cần)
          content = await File(filePath).readAsString(encoding: utf8);
          print("Nội dung TXT:\n$content");
        } catch (e) {
          print("Lỗi khi đọc file TXT: $e");
        }
      } else if (ext == '.docx') {
        final fileBytes = await File(filePath).readAsBytes();
        content = await docxToText(fileBytes); // ✅ truyền dạng byte
      } else {
        print("Không hỗ trợ định dạng này.");
        return;
      }

      print("Nội dung:\n$content");
      inputText.value = content;
    } else {
      print("Không chọn file.");
    }
  }

  Future<void> saveProfile() async {
    try {
      ProfileCompanyModel profile = ProfileCompanyModel(
          website: websiteController.text,
          headcount: headcountController.text,
          address: addressController.text,
          preview: inputText.value,
          facebook: facebookController.text,
          twitter: twitterController.text,
          linkedIn: linkedInController.text);
      await _fb.saveProfileCompany(profile);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
