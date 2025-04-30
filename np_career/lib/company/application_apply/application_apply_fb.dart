import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
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

  Future<void> addCvToJobInDate(
    BuildContext context, {
    required String idJob,
    required String jobName,
    required String idCV,
    required String userName,
    required String type,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd_MM_yyyy').format(picked);
      final docRef = FirebaseFirestore.instance
          .collection('interview_schedule')
          .doc(formattedDate);

      // Lấy dữ liệu cũ nếu có
      DocumentSnapshot snapshot = await docRef.get();
      List<dynamic> listSchedule = [];

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;
        listSchedule = data['list_schedule'] ?? [];
      }

      // Tìm kiếm job theo idJob
      bool found = false;
      for (var item in listSchedule) {
        if (item['idJob'] == idJob) {
          (item['listCv'] as List).add({
            'idCv': idCV,
            'userName': userName,
            'type': type,
          });
          found = true;
          break;
        }
      }

      // Nếu chưa có thì thêm job mới
      if (!found) {
        listSchedule.add({
          'idJob': idJob,
          'jobName': jobName,
          'listCv': [
            {
              'idCv': idCV,
              'userName': userName,
              'type': type,
            }
          ]
        });
      }

      // Lưu lại lên Firebase
      await docRef.set({
        'list_schedule': listSchedule,
      });

      print("Job updated on $formattedDate");
    }
  }
}
