import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:np_career/model/cv_model.dart';

class InterviewScheduleFb {
  FirebaseFirestore _fb = FirebaseFirestore.instance;

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
    if (isAllScheduleSelected) {
      return _fb.collection('interview_schedule').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'docId': doc.id,
            'list_schedule': data['list_schedule'] ?? [],
          };
        }).toList();
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

        return [
          {
            'docId': docSnap.id,
            'list_schedule': data['list_schedule'] ?? [],
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
