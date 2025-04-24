import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:np_career/model/job_post_model.dart';

class JobDetailFb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<List<bool>> getSavedJobsStatus() async {
    final savedDoc = await _firestore
        .collection('job_actions')
        .doc(_auth.currentUser!.uid)
        .get();

    final savedJobs = savedDoc.data()?['saves'] ?? [];

    final jobQuery = await _firestore.collection('job_company').get();
    final jobDocs = jobQuery.docs;

    List<bool> jobStatusList = [];

    for (var doc in jobDocs) {
      final jpsList = doc.data()['jps'] as List<dynamic>? ?? [];

      for (var job in jpsList) {
        final jobId = job['id'];
        if (jobId != null) {
          jobStatusList.add(savedJobs.contains(jobId));
          print("svJob: ${savedJobs.contains(jobId)} - id: $jobId");
        } else {
          jobStatusList.add(false);
          print("jobId is null in jps for document: ${doc.id}");
        }
      }
    }

    print("fb : ${jobStatusList}");

    return jobStatusList;
  }
}
