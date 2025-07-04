import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:np_career/company/profile_company/profile_company_controller.dart';
import 'package:np_career/model/profile_company_model.dart';

class ProfileCompanyFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveProfileCompany(ProfileCompanyModel profile) async {
    try {
      await _firestore
          .collection('profile_company')
          .doc(_auth.currentUser!.uid)
          .set(profile.toJson());
    } catch (e) {
      print("Error saving ProfileCompany: $e");
    }
  }

  Future<Map<String, dynamic>?> getProfileCompany(String? companyID) async {
    final uid = (companyID == null || companyID.isEmpty)
        ? _auth.currentUser!.uid
        : companyID;

    final doc = await _firestore.collection('profile_company').doc(uid).get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }
}
