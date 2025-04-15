import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
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
}
