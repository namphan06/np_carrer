import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:np_career/company/application_apply/application_apply_fb.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationApplyController extends GetxController {
  ApplicationApplyFb _fb = Get.put(ApplicationApplyFb());

  RxString filter = "All".obs;

  Future<void> getCv(String uid, String type) async {
    try {
      CvModel model = await _fb.getCvModel(uid, type);
      EnumCvOutput.cv1_no1.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> sendEmail(String mailFrom, String type, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    String? emailBodyContent;

    if (type == 'accept') {
      emailBodyContent = prefs.getString('emailAccept');
    } else if (type == 'reject') {
      emailBodyContent = prefs.getString('emailReject');
    }

    print('DEBUG: Nội dung gốc emailBodyContent: $emailBodyContent');

    if (emailBodyContent == null || emailBodyContent.isEmpty) {
      final errorMessage =
          'Lỗi: Không tìm thấy nội dung email được lưu cho loại "$type".';
      print(errorMessage);

      return;
    }

    final String recipientEmail = mailFrom;
    final String subject = "Job Application";

    // Tạo nội dung body gốc với xuống dòng
    final String body = """
Dear $userName,

We would like to inform you that your application has been $type.

$emailBodyContent

Best regards,
The Hiring Team
""";

    print('DEBUG: Nội dung body đầy đủ trước khi mã hóa:\n$body');

    // --- Bước quan trọng: Tự mã hóa và ghép chuỗi ---

    // 1. Mã hóa từng thành phần bằng Uri.encodeComponent
    //    Hàm này đảm bảo ' ' -> '%20', '\n' -> '%0A', v.v.
    final String encodedSubject = Uri.encodeComponent(subject);
    final String encodedBody = Uri.encodeComponent(body);

    // 2. Ghép chuỗi mailto: hoàn chỉnh bằng tay
    final String mailtoUriString =
        'mailto:$recipientEmail?subject=$encodedSubject&body=$encodedBody';

    // In ra chuỗi URI cuối cùng được tạo thủ công để kiểm tra
    print('DEBUG: Final mailto URI String (manual encode): $mailtoUriString');

    // 3. Parse chuỗi vừa tạo thành đối tượng Uri để dùng với url_launcher mới
    final Uri emailUri = Uri.parse(mailtoUriString);

    // --- Hết phần sửa đổi ---

    try {
      // Sử dụng canLaunchUrl và launchUrl với Uri đã tạo thủ công
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(
          emailUri,
          mode: LaunchMode.externalApplication,
        );
        print('INFO: Đã yêu cầu mở ứng dụng email.');
      } else {
        final errorMessage =
            'Lỗi: Không thể mở ứng dụng email. Kiểm tra cài đặt.';
        print(errorMessage);
      }
    } catch (e) {
      final errorMessage = 'Lỗi không xác định khi mở email: $e';
      print(errorMessage);
    }
  }
}
