import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CvSettingNo1 extends GetxController {
  String getImageUrl(String url) {
    // Kiểm tra nếu là link Google Drive
    final RegExp driveReg =
        RegExp(r'drive.google.com\/file\/d\/([a-zA-Z0-9_-]+)');

    final match = driveReg.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }

    // Nếu không phải link Google Drive thì trả về link bình thường
    return url;
  }

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
