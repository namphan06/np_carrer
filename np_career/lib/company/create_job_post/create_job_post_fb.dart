import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:uuid/uuid.dart';

class CreateJobPostFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> createJobPost(
  //     JobPostModel model, String nameCompany, String randomId) async {
  //   try {
  //     await _firestore.collection("jobs").doc(randomId).set({
  //       'id': randomId,
  //       ...model.toJson(),
  //     });

  //     final userDoc =
  //         _firestore.collection("job_company").doc(_auth.currentUser!.uid);

  //     final snapshot = await userDoc.get();
  //     List<dynamic> existingJps = [];

  //     if (snapshot.exists && snapshot.data() != null) {
  //       existingJps = snapshot.data()!['jps'] ?? [];
  //     }

  //     existingJps.add({
  //       'id': randomId,
  //       'name': model.name,
  //       'city': model.city,
  //       'minSalary': model.minSalary,
  //       'maxSalary': model.maxSalary,
  //       'nameCompany': nameCompany,
  //       'currencyUnit': model.currencyUnit,
  //       'experience': model.experience,
  //       'jobInterests': model.jobInterests,
  //       'companyId': _auth.currentUser!.uid
  //     });

  //     await userDoc.set({'jps': existingJps});
  //   } catch (err) {
  //     Get.snackbar("Error", "Fail create job post");
  //   }
  // }

  Future<void> createJobPost(
      JobPostModel model, String nameCompany, String randomId) async {
    try {
      // 1. Tạo job
      await _firestore.collection("jobs").doc(randomId).set({
        'id': randomId,
        ...model.toJson(),
        'createdAt': Timestamp.now(),
      });

      // 2. Thêm job vào job_company
      final userDoc =
          _firestore.collection("job_company").doc(_auth.currentUser!.uid);
      final snapshot = await userDoc.get();
      List<dynamic> existingJps = snapshot.data()?['jps'] ?? [];

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
        'companyId': _auth.currentUser!.uid,
        'createdAt': Timestamp.now(),
      });

      await userDoc.set({'jps': existingJps});

      // 3. Quét qua tất cả user trong collection notification
      final notiSnapshot = await _firestore.collection("notification").get();
      for (var doc in notiSnapshot.docs) {
        final data = doc.data();

        final bool receiveFromCompany = data['receive_from_company'] ?? false;
        final bool receiveMatchingJobs = data['receive_matching_jobs'] ?? false;
        final bool receiveSimilarJobs = data['receive_similar_jobs'] ?? false;

        final List<dynamic> followsCompany = data['followsCompany'] ?? [];
        final List<dynamic> listInterestApply = data['listInterestApply'] ?? [];
        final List<dynamic> listInterestProfile =
            data['listInterestProfile'] ?? [];

        final List<dynamic> jobInterests = model.jobInterests;

        bool shouldNotify = false;

        if (receiveFromCompany &&
            followsCompany.contains(_auth.currentUser!.uid)) {
          shouldNotify = true;
        }

        if (!shouldNotify && receiveMatchingJobs) {
          if (jobInterests.any((item) => listInterestApply.contains(item))) {
            shouldNotify = true;
          }
        }

        if (!shouldNotify && receiveSimilarJobs) {
          if (jobInterests.any((item) => listInterestProfile.contains(item))) {
            shouldNotify = true;
          }
        }

        if (shouldNotify) {
          await _firestore.collection("notification").doc(doc.id).set({
            'notifications': FieldValue.arrayUnion([
              {
                'option': 'create job',
                'status': false,
                'text':
                    "${model.name} \n 🎉Một công việc mới phù hợp với bạn vừa được đăng bởi công ty $nameCompany! \n 📅Hãy kiểm tra ngay để không bỏ lỡ cơ hội này.",
                'timestamp': Timestamp.now(),
              }
            ])
          }, SetOptions(merge: true));
        }
      }

      print("Job created and notifications sent if matched.");
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
              'companyId': _auth.currentUser!.uid,
              'createdAt': Timestamp.now(),
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
