import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/login/login.dart';

class SignupFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String role,
  }) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        UserModel user = UserModel(
            username: username,
            uid: cred.user!.uid,
            email: email,
            phone: phone,
            role: role);

        _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        Get.to(Login());
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
