import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationSettingController extends GetxController {
  var receiveFromCompany = false.obs;
  var receiveMatchingJobs = false.obs;
  var receiveSimilarJobs = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveNotificationSettings() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('notification').doc(uid).set({
      'receive_from_company': receiveFromCompany.value,
      'receive_matching_jobs': receiveMatchingJobs.value,
      'receive_similar_jobs': receiveSimilarJobs.value,
    }, SetOptions(merge: true));

    print("Notification settings saved to Firebase.");
  }

  Future<void> loadNotificationSettings() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('notification').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      receiveFromCompany.value = data['receive_from_company'] ?? false;
      receiveMatchingJobs.value = data['receive_matching_jobs'] ?? false;
      receiveSimilarJobs.value = data['receive_similar_jobs'] ?? false;

      print("Notification settings loaded from Firebase.");
    } else {
      print("No notification settings found.");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
