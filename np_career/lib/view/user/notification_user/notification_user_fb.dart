import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:np_career/view/user/home/home_user_controller.dart';

class NotificationUserFb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fb = FirebaseFirestore.instance;
  HomeUserController ctr = Get.put(HomeUserController());

  Stream<DocumentSnapshot> getNotification() {
    return _fb
        .collection('notification')
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> markNotificationAsRead(int index) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final docRef = _fb.collection('notification').doc(uid);
    final snapshot = await docRef.get();

    if (!snapshot.exists) return;

    final data = snapshot.data();
    if (data == null || data['notifications'] == null) return;

    List notifications = List.from(data['notifications']);
    if (index >= notifications.length) return;

    notifications[index]['status'] = true;

    await docRef.update({'notifications': notifications});
    ctr.countUnreadNotifications();
  }
}
