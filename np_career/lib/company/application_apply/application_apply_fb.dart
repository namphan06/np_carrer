import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/model/cv_model.dart';

class ApplicationApplyFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getApplicationApply() {
    return _firestore.collection("job_actions").snapshots();
  }

  Future<Map<String, dynamic>> getUserDetail(String userId) async {
    final doc = await _firestore.collection("users").doc(userId).get();

    if (doc.exists) {
      final data = doc.data()!;
      return {
        'username': data['username'],
        'email': data['email'],
        'phone': data['phone'],
      };
    } else {
      throw Exception('User not found');
    }
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
}
