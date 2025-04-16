import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class ManagementJobPostFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> getListJobPost() {
    try {
      return _firestore
          .collection('job_company')
          .doc(_auth.currentUser!.uid)
          .snapshots();
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return const Stream.empty(); // Trả về stream rỗng khi có lỗi
    }
  }
}
