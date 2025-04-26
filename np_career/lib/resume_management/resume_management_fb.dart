import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:np_career/model/cv_model.dart';
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

  Future<CvModel> getCvModel(String uid, String type) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(type).doc(uid).get();

      if (snapshot.exists) {
        return CvModel.fromSnap(snapshot);
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
}
