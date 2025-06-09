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

  Stream<List<String>> getMatchingProfileIdsStream() async* {
    await for (var jobCompanySnapshot in _firestore
        .collection('job_company')
        .doc(_auth.currentUser!.uid)
        .snapshots()) {
      final data = jobCompanySnapshot.data();
      if (data == null || !data.containsKey('jps')) {
        yield [];
        continue;
      }

      List<dynamic> jps = data['jps'];
      if (jps.isEmpty) {
        yield [];
        continue;
      }

      // 👉 Lấy tất cả jobInterests từ các phần tử trong jps
      Set<String> allJobInterests = {};
      for (var item in jps) {
        if (item is Map<String, dynamic> && item.containsKey('jobInterests')) {
          List<dynamic> interests = item['jobInterests'];
          allJobInterests.addAll(interests.whereType<String>());
        }
      }

      if (allJobInterests.isEmpty) {
        yield [];
        continue;
      }

      // 👉 Chia batch vì arrayContainsAny chỉ cho phép 10 phần tử
      final batches = <List<String>>[];
      final listInterests = allJobInterests.toList();
      for (var i = 0; i < listInterests.length; i += 10) {
        batches.add(listInterests.sublist(
            i, i + 10 > listInterests.length ? listInterests.length : i + 10));
      }

      Set<String> profileIds = {};

      for (var batch in batches) {
        final snapshot = await _firestore
            .collection('my_profile')
            .where('jobInterests', arrayContainsAny: batch)
            .get();

        for (var doc in snapshot.docs) {
          profileIds.add(doc.id);
        }
      }

      print("Profile IDs: $profileIds");
      yield profileIds.toList();
    }
  }

  Future<List<Map<String, dynamic>>> getProfilesByIds(List<String> ids) async {
    final firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> profiles = [];

    for (var id in ids) {
      final doc = await firestore.collection('my_profile').doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['securitySetting'] == true) {
          profiles.add(data);
        }
      }
    }

    return profiles;
  }
}
