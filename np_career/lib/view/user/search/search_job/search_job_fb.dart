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
        _firestore.collection('job_actions').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> currentJobs = docSnap.data()?['saves'] ?? [];

    if (currentJobs.contains(jobId)) {
      await docRef.update({
        'saves': FieldValue.arrayRemove([jobId])
      });
    } else {
      // Nếu chưa có thì thêm
      await docRef.set({
        'saves': FieldValue.arrayUnion([jobId])
      }, SetOptions(merge: true));
    }
  }

  Future<bool> isJobSaved({
    required String jobId,
  }) async {
    final docRef =
        _firestore.collection('job_actions').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> jobs = docSnap.data()?['saves'] ?? [];

    return jobs.contains(jobId);
  }

  Future<Map<String, List>> getSavedJobsStatusAndIds() async {
    final savedDoc = await _firestore
        .collection('job_actions')
        .doc(_auth.currentUser!.uid)
        .get();

    final savedJobs = savedDoc.data()?['saves'] ?? [];

    final jobQuery = await _firestore.collection('job_company').get();
    final jobDocs = jobQuery.docs;

    List<bool> jobStatusList = [];
    List<String> jobIdList = [];

    for (var doc in jobDocs) {
      final jpsList = doc.data()['jps'] as List<dynamic>? ?? [];

      for (var job in jpsList) {
        final jobId = job['id'];
        if (jobId != null) {
          final isSaved = savedJobs.contains(jobId);
          if (isSaved) {
            jobIdList.add(jobId);
          }
          jobStatusList.add(isSaved);
          // print("svJob: $isSaved - id: $jobId");
        } else {
          jobStatusList.add(false);
          jobIdList.add("null");
          // print("jobId is null in jps for document: ${doc.id}");
        }
      }
    }

    // print("fb : $jobStatusList");
    // print("ids: $jobIdList");

    return {
      'status': jobStatusList,
      'ids': jobIdList,
    };
  }

  Future<List<String>> getAppliedJobIds() async {
    final appliedDoc = await _firestore
        .collection('job_actions')
        .doc(_auth.currentUser!.uid)
        .get();

    final appliedList =
        appliedDoc.data()?['applied_list'] as List<dynamic>? ?? [];

    List<String> jobIdList = [];

    for (var item in appliedList) {
      if (item is Map<String, dynamic> && item.containsKey('jobId')) {
        final jobId = item['jobId'];
        if (jobId != null) {
          jobIdList.add(jobId.toString());
        }
      }
    }

    return jobIdList;
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
