import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:np_career/model/cv_model.dart';

import 'package:np_career/model/job_post_model.dart';
import 'package:uuid/uuid.dart';

class JobDetailFb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> toggleSavedJob({
    required String jobId,
  }) async {
    final docRef =
        _firestore.collection('user_actions').doc(_auth.currentUser!.uid);

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
        _firestore.collection('user_actions').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> jobs = docSnap.data()?['saves'] ?? [];

    return jobs.contains(jobId);
  }

  Future<List<bool>> getSavedJobsStatus() async {
    final savedDoc = await _firestore
        .collection('user_actions')
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

  Stream<DocumentSnapshot> getListCv() {
    return _firestore
        .collection("cv_user")
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> applyCv(
      String cvId, String companyId, String jobId, String typeCv) async {
    try {
      await _firestore
          .collection("user_actions")
          .doc(_auth.currentUser!.uid)
          .set({
        'applied_list': FieldValue.arrayUnion([
          {
            'id': Uuid().v4(),
            'cvId': cvId,
            'userId': _auth.currentUser!.uid,
            'companyId': companyId,
            'jobId': jobId,
            'typeCV': typeCv
          }
        ]),
      }, SetOptions(merge: true)); // merge để giữ dữ liệu cũ, chỉ thêm mới
    } catch (err) {
      Get.snackbar("Error", err.toString());
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
