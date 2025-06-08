import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AnalyticsFb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Map<String, int>> get statsStream async* {
    final String companyId = _auth.currentUser!.uid;

    await for (var userActionsSnapshot
        in _firestore.collection('user_actions').snapshots()) {
      int totalJobPosts = 0;
      int totalApplicants = 0;
      int totalAccepted = 0;
      int totalRejected = 0;

      final companyDoc =
          await _firestore.collection('job_company').doc(companyId).get();
      if (companyDoc.exists) {
        final data = companyDoc.data() as Map<String, dynamic>;
        if (data['jps'] is List) {
          totalJobPosts = (data['jps'] as List).length;
        }
      }

      for (var doc in userActionsSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('applied_list')) {
          for (var app in data['applied_list']) {
            if (app['companyId'] == companyId) {
              totalApplicants++;
              if (app['response'] == 'accept') {
                totalAccepted++;
              } else if (app['response'] == 'reject') {
                totalRejected++;
              }
            }
          }
        }
      }

      yield {
        'posts': totalJobPosts,
        'applicants': totalApplicants,
        'accepted': totalAccepted,
        'rejected': totalRejected,
      };
    }
  }
}
