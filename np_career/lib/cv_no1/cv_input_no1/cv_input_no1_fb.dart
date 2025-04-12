import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:uuid/uuid.dart';

class CvInputNo1Fb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createCvNo1(CvModel model) async {
    try {
      await _firestore.collection("cv_no1").doc(model.uid).set({
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
        'type': 'cv_no1',
      });

      await userDoc.set({'cvs': existingCvs});
    } catch (err) {
      Get.snackbar("Error", "Fail create cv");
    }
  }
}
