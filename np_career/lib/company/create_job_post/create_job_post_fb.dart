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
}
