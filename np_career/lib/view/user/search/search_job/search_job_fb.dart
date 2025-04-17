import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchJobFb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getListJob() {
    try {
      return _firestore.collection('job_company').snapshots();
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return const Stream.empty();
    }
  }
}
