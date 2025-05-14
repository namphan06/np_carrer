import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:uuid/uuid.dart';

class CvInputNo2Fb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createCvNo2(
      CvModelV2 model, String type, String type_input) async {
    try {
      await _firestore.collection(type).doc(model.uid).set({
        'id': model.uid,
        ...model.toJson(),
      });

      final userDoc =
          _firestore.collection("cv_user").doc(_auth.currentUser!.uid);

      final snapshot = await userDoc.get();
      List<dynamic> existingCvs = [];

      if (snapshot.exists && snapshot.data() != null) {
        existingCvs = snapshot.data()!['cvs'] ?? [];
      }

      existingCvs.add({
        'id': model.uid,
        'position': model.position,
        'type': type,
        'typeInput': type_input,
      });

      await userDoc.set({'cvs': existingCvs});
    } catch (err) {
      Get.snackbar("Error", "Fail create cv");
    }
  }

  Future<void> updateCvNo2(CvModelV2 model, String type) async {
    try {
      // Cập nhật dữ liệu chính trong collection theo type
      print("===> Đang cập nhật CV với UID: ${model.uid} vào Firestore...");
      await _firestore.collection(type).doc(model.uid).update(model.toJson());

      final userDoc =
          _firestore.collection("cv_user").doc(_auth.currentUser!.uid);

      final snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> existingCvs = snapshot.data()!['cvs'] ?? [];

        // Tìm và cập nhật CV có cùng id
        bool cvUpdated = false;
        for (var cv in existingCvs) {
          if (cv['id'] == model.uid) {
            print("===> Đang cập nhật CV với ID: ${model.uid}");
            cv['position'] = model.position;
            cv['type'] = type;
            cvUpdated = true;
            break;
          }
        }

        if (cvUpdated) {
          await userDoc.update({'cvs': existingCvs});
          print("===> CV đã được cập nhật thành công.");
        } else {
          print("===> Không tìm thấy CV với ID: ${model.uid}");
        }
      } else {
        print("===> Không tìm thấy tài liệu người dùng.");
      }
    } catch (err) {
      print("===> Lỗi khi cập nhật CV: $err"); // In chi tiết lỗi
      Get.snackbar("Error", "Fail update cv");
    }
  }
}
