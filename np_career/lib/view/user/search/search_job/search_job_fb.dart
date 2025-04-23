import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/model/job_post_model.dart';

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

  Future<JobPostModel?> getJobDetail(String job_id) async {
    try {
      final snap = await _firestore.collection("jobs").doc(job_id).get();

      if (!snap.exists) {
        Get.snackbar(
          "Error",
          "Job information not found.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      return JobPostModel.fromSnap(snap);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load job data: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
