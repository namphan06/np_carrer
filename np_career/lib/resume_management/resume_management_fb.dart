import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:np_career/enum/enum_cv_type_model.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/model/cv_model_v3.dart';
import 'package:uuid/uuid.dart';

class ResumeManagementFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> getListCv() {
    return _firestore
        .collection("cv_user")
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  Future<dynamic> getCvModel(String uid, String type) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(type).doc(uid).get();

      if (snapshot.exists) {
        return CvTypeModel.fromString(type).fromSnap(snapshot);
      } else {
        throw Exception("CV not found");
      }
    } catch (err) {
      throw Exception("Error getting CV: $err");
    }
  }

  Future<void> uploadCv(String link, String position) async {
    try {
      var uuid = Uuid();
      String randomId = uuid.v4();
      await _firestore
          .collection("upload_cv")
          .doc(randomId)
          .set({'id': randomId, 'link': link, 'position': position});

      final userDoc =
          _firestore.collection("cv_user").doc(_auth.currentUser!.uid);

      final snapshot = await userDoc.get();
      List<dynamic> existingCvs = [];

      if (snapshot.exists && snapshot.data() != null) {
        existingCvs = snapshot.data()!['cvs'] ?? [];
      }

      existingCvs.add({
        'id': randomId,
        'position': position,
        'type': 'upload',
      });

      await userDoc.set({'cvs': existingCvs});
    } catch (err) {
      Get.snackbar("Error", "Fail create cv");
    }
  }

  Future<String> getLink(String uid) async {
    DocumentSnapshot doc =
        await _firestore.collection("upload_cv").doc(uid).get();
    return doc.get('link') as String;
  }

  Future<void> deleteCvNo1(String uid, String type) async {
    try {
      // Xóa CV khỏi collection theo type
      await _firestore.collection(type).doc(uid).delete();

      // Lấy document người dùng hiện tại
      final userDoc =
          _firestore.collection("cv_user").doc(_auth.currentUser!.uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> existingCvs = snapshot.data()!['cvs'] ?? [];

        // Lọc ra danh sách mới không chứa CV cần xóa
        existingCvs.removeWhere((cv) => cv['id'] == uid);

        // Cập nhật lại danh sách CV
        await userDoc.update({'cvs': existingCvs});
      }

      Get.snackbar("Success", "CV deleted successfully");
    } catch (err) {
      Get.snackbar("Error", "Fail to delete CV");
    }
  }
}
