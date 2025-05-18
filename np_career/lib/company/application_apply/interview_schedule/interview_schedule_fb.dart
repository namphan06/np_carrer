import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:np_career/model/cv_model.dart';

class InterviewScheduleFb {
  FirebaseFirestore _fb = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream<List<Map<String, dynamic>>> getJobScheduleStream(
  //     bool isAllScheduleSelected, DateTime? selectedDate) {
  //   if (isAllScheduleSelected) {
  //     return _fb.collection('interview_schedule').snapshots().map((snapshot) {
  //       List<Map<String, dynamic>> allSchedules = [];

  //       for (var doc in snapshot.docs) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         final list = data['list_schedule'] as List<dynamic>? ?? [];

  //         for (var item in list) {
  //           allSchedules.add(Map<String, dynamic>.from(item));
  //         }
  //       }

  //       return allSchedules;
  //     });
  //   } else {
  //     if (selectedDate == null) {
  //       return Stream.value([]); // Không có ngày chọn
  //     }

  //     String formattedDate = DateFormat('dd_MM_yyyy').format(selectedDate);
  //     return _fb
  //         .collection('interview_schedule')
  //         .doc(formattedDate)
  //         .snapshots()
  //         .map((snapshot) {
  //       if (!snapshot.exists) return [];
  //       final data = snapshot.data() as Map<String, dynamic>;
  //       final list = data['list_schedule'] ?? [];
  //       return List<Map<String, dynamic>>.from(list);
  //     });
  //   }
  // }

  Stream<List<Map<String, dynamic>>> getJobScheduleStream(
      bool isAllScheduleSelected, DateTime? selectedDate) {
    final String currentUserId = _auth.currentUser?.uid ?? '';

    if (isAllScheduleSelected) {
      return _fb.collection('interview_schedule').snapshots().map((snapshot) {
        final allDocs = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final List schedules = data['list_schedule'] ?? [];

          final filteredSchedules = schedules.where((item) {
            if (item == null) return false;
            if (item is! Map<String, dynamic>) return false;
            return item['idCompany'] == currentUserId;
          }).toList();

          if (filteredSchedules.isEmpty) {
            // Bỏ phần tử này luôn
            return null;
          }

          return {
            'docId': doc.id,
            'list_schedule': filteredSchedules,
          };
        }).toList();

        // Loại bỏ các phần tử null
        return allDocs.whereType<Map<String, dynamic>>().toList();
      });
    } else {
      if (selectedDate == null) return Stream.value([]);
      final formattedDate = DateFormat('dd_MM_yyyy').format(selectedDate);

      return _fb
          .collection('interview_schedule')
          .doc(formattedDate)
          .snapshots()
          .map((docSnap) {
        if (!docSnap.exists) return [];

        final data = docSnap.data() as Map<String, dynamic>;
        final List schedules = data['list_schedule'] ?? [];

        final filteredSchedules = schedules.where((item) {
          if (item == null) return false;
          if (item is! Map<String, dynamic>) return false;
          return item['idCompany'] == currentUserId;
        }).toList();

        if (filteredSchedules.isEmpty) {
          return [];
        }

        return [
          {
            'docId': docSnap.id,
            'list_schedule': filteredSchedules,
          }
        ];
      });
    }
  }

  Future<CvModel> getCvModel(String uid, String type) async {
    try {
      DocumentSnapshot snapshot = await _fb.collection(type).doc(uid).get();

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
