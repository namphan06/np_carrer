import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String username;
  final String? phone;
  final String role;

  const UserModel(
      {required this.username,
      required this.uid,
      required this.email,
      this.phone,
      required this.role});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        username: snapshot["username"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        phone: snapshot["phone"],
        role: snapshot["role"]);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "phone": phone,
        "role": role
      };
}
