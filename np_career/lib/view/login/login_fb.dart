import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:np_career/model/user_model.dart';
import 'package:np_career/view/screen/home.dart';

class LoginFb {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Email and password cannot be empty.";
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";

      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      }

      return errorMessage;
    } catch (err) {
      return "An unexpected error occurred.";
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      UserCredential userCredential = await signInWithGoogleAccount();

      if (userCredential.user != null) {
        DocumentSnapshot docSnap = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (!docSnap.exists) {
          UserModel user = UserModel(
              username: userCredential.user!.displayName ?? 'New User',
              uid: userCredential.user!.uid,
              email: userCredential.user!.email ?? '',
              role: "user");

          // Lưu thông tin người dùng vào Firestore
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(user.toJson());
        }
        Get.to(Home());
      }
    } catch (err) {
      Get.snackbar("Error", err.toString());
      print(err.toString());
    }
  }

  Future<UserCredential> signInWithGoogleAccount() async {
    try {
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw 'Google sign-in aborted by user';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (err) {
      throw 'Error during Google sign-in: $err';
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<UserModel> getUser() async {
    User user = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(user.uid).get();
    return UserModel.fromSnap(documentSnapshot);
  }
}
