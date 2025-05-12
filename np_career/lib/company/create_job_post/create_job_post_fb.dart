import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:uuid/uuid.dart';

class CreateJobPostFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createJobPost(
      JobPostModel model, String nameCompany, String randomId) async {
    try {
      await _firestore.collection("jobs").doc(randomId).set({
        'id': randomId,
        ...model.toJson(),
      });

      final userDoc =
          _firestore.collection("job_company").doc(_auth.currentUser!.uid);

      final snapshot = await userDoc.get();
      List<dynamic> existingJps = [];

      if (snapshot.exists && snapshot.data() != null) {
        existingJps = snapshot.data()!['jps'] ?? [];
      }

      existingJps.add({
        'id': randomId,
        'name': model.name,
        'city': model.city,
        'minSalary': model.minSalary,
        'maxSalary': model.maxSalary,
        'nameCompany': nameCompany,
        'currencyUnit': model.currencyUnit,
        'experience': model.experience,
        'jobInterests': model.jobInterests,
        'companyId': _auth.currentUser!.uid
      });

      await userDoc.set({'jps': existingJps});
    } catch (err) {
      Get.snackbar("Error", "Fail create job post");
    }
  }

  Future<void> updateJobPost(
      String jobId, JobPostModel updatedModel, String nameCompany) async {
    try {
      final jobDoc = _firestore.collection("jobs").doc(jobId);
      final userDoc =
          _firestore.collection("job_company").doc(_auth.currentUser!.uid);

      // Cập nhật thông tin chi tiết job
      await jobDoc.update({
        ...updatedModel.toJson(),
      });

      // Cập nhật thông tin trong job_company
      final snapshot = await userDoc.get();
      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> jps = snapshot.data()!['jps'] ?? [];

        for (int i = 0; i < jps.length; i++) {
          if (jps[i]['id'] == jobId) {
            jps[i] = {
              'id': jobId,
              'name': updatedModel.name,
              'city': updatedModel.city,
              'minSalary': updatedModel.minSalary,
              'maxSalary': updatedModel.maxSalary,
              'nameCompany': nameCompany,
              'currencyUnit': updatedModel.currencyUnit,
              'experience': updatedModel.experience,
              'jobInterests': updatedModel.jobInterests,
              'companyId': _auth.currentUser!.uid
            };
            break;
          }
        }

        await userDoc.update({'jps': jps});
      }
    } catch (err) {
      Get.snackbar("Error", "Fail update job post");
    }
  }

  Future<JobPostModel> getDataJob(String jobId) async {
    DocumentSnapshot doc = await _firestore.collection("jobs").doc(jobId).get();
    return JobPostModel.fromSnap(doc);
  }
}
