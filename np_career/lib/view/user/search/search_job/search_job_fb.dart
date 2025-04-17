import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchJobFb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getListJob() {
    try {
      return _firestore.collection('job_company').snapshots();
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return const Stream.empty();
    }
  }

  Future<void> toggleSavedJob({
    required String jobId,
  }) async {
    final docRef =
        _firestore.collection('saved_job').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> currentJobs = docSnap.data()?['jobs'] ?? [];

    if (currentJobs.contains(jobId)) {
      await docRef.update({
        'jobs': FieldValue.arrayRemove([jobId])
      });
    } else {
      // Nếu chưa có thì thêm
      await docRef.set({
        'jobs': FieldValue.arrayUnion([jobId])
      }, SetOptions(merge: true));
    }
  }

  Future<bool> isJobSaved({
    required String jobId,
  }) async {
    final docRef =
        _firestore.collection('saved_job').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> jobs = docSnap.data()?['jobs'] ?? [];

    return jobs.contains(jobId);
  }
}
