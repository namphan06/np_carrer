import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class ManagementJobPostFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot> getListJobPost() {
    try {
      return _firestore
          .collection('job_company')
          .doc(_auth.currentUser!.uid)
          .snapshots();
    } catch (err) {
      Get.snackbar("Error", err.toString());
      return const Stream.empty(); // Trả về stream rỗng khi có lỗi
    }
  }

  Future<void> deleteJobPost(String jobId) async {
    try {
      // Xóa job khỏi collection "jobs"
      await _firestore.collection("jobs").doc(jobId).delete();

      // Lấy document công ty của user hiện tại
      final userDoc =
          _firestore.collection("job_company").doc(_auth.currentUser!.uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        List<dynamic> jps = snapshot.data()!['jps'] ?? [];

        // Lọc ra danh sách mới không chứa job cần xóa
        jps.removeWhere((job) => job['id'] == jobId);

        // Cập nhật lại danh sách
        await userDoc.update({'jps': jps});
      }

      Get.snackbar("Success", "Job post deleted successfully");
    } catch (err) {
      Get.snackbar("Error", "Fail delete job post");
    }
  }
}
