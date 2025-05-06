import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/my_profile_model.dart';

class MyProfileFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveMyProfile(MyProfileModel model) async {
    try {
      await _firestore
          .collection('my_profile')
          .doc(_auth.currentUser!.uid)
          .set({'id': _auth.currentUser!.uid, ...model.toJson()});
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Stream<MyProfileModel> getProfile() {
    return FirebaseFirestore.instance
        .collection('my_profile')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((doc) => MyProfileModel.fromSnap(doc));
  }

  Future<MyProfileModel?> getMyProfile() async {
    DocumentSnapshot doc = await _firestore
        .collection('my_profile')
        .doc(_auth.currentUser!.uid)
        .get();

    if (doc.exists) {
      return MyProfileModel.fromSnap(doc);
    }
    return null;
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
