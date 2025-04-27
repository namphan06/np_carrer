import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchApplicationFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getListApplication() {
    try {
      return _firestore.collection('my_profile').snapshots();
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return const Stream.empty();
    }
  }

  Future<void> toggleSavedApplication({
    required String jobId,
  }) async {
    final docRef = _firestore
        .collection('application_actions')
        .doc(_auth.currentUser!.uid);

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

  Future<bool> isApplicationSaved({
    required String jobId,
  }) async {
    final docRef = _firestore
        .collection('application_actions')
        .doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> jobs = docSnap.data()?['saves'] ?? [];

    return jobs.contains(jobId);
  }

  Future<List<bool>> getSavedApplicationsStatus() async {
    final savedDoc = await _firestore
        .collection('application_actions')
        .doc(_auth.currentUser!.uid)
        .get();

    final savedApplications = savedDoc.data()?['saves'] ?? [];

    final jobQuery = await _firestore.collection('my_profile').get();
    final jobDocs = jobQuery.docs;

    List<bool> applicationStatusList = [];

    for (var doc in jobDocs) {
      final data = doc.data();
      final applicationId = data['id'];

      if (applicationId != null) {
        applicationStatusList.add(savedApplications.contains(applicationId));
        print(
            "svApplication: ${savedApplications.contains(applicationId)} - id: $applicationId");
      } else {
        applicationStatusList.add(false);
        print("ApplicationId is null in document: ${doc.id}");
      }
    }

    print("fb : $applicationStatusList");

    return applicationStatusList;
  }
}
