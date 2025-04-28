import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/model/cv_model.dart';

class ApplicationApplyFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getApplicationApply() {
    return _firestore.collection("job_actions").snapshots();
  }

  Future<Map<String, dynamic>> getUserDetail(String userId) async {
    final doc = await _firestore.collection("users").doc(userId).get();

    if (doc.exists) {
      final data = doc.data()!;
      return {
        'username': data['username'],
        'email': data['email'],
        'phone': data['phone'],
      };
    } else {
      throw Exception('User not found');
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

  Future<void> updateResponseStatus(
      String applicationId, String response, String userId) async {
    try {
      // Truyền vào jobId và userId để xác định chính xác ứng viên cần cập nhật
      final jobActionRef = _firestore.collection('job_actions').doc(userId);

      // Lấy danh sách ứng viên đã ứng tuyển
      final jobActionSnapshot = await jobActionRef.get();

      if (jobActionSnapshot.exists) {
        final jobActionData = jobActionSnapshot.data() as Map<String, dynamic>;
        final applications = jobActionData['applied_list'] as List<dynamic>;

        // Cập nhật trường response của ứng viên cần thay đổi
        for (var i = 0; i < applications.length; i++) {
          if (applications[i]['id'] == applicationId) {
            applications[i]['response'] = response.toLowerCase();
            break;
          }
        }

        // Cập nhật lại danh sách ứng viên vào Firebase
        await jobActionRef.update({
          'applied_list': applications, // Cập nhật toàn bộ danh sách ứng viên
        });
      } else {
        print('Job action not found');
      }
    } catch (e) {
      print('Error updating response: $e');
    }
  }
}
