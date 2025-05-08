import 'package:cloud_firestore/cloud_firestore.dart';

class TopCompanyFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Your Stream method
  Stream<List<DocumentSnapshot>> getAllCompanies() {
    // Step 1: Get all valid UIDs from the 'profile_company' collection
    Stream<QuerySnapshot> profileCompanyStream =
        _firestore.collection('profile_company').snapshots();

    return profileCompanyStream.asyncMap((profileSnapshot) async {
      // Extract all valid UIDs
      List<String> validUids =
          profileSnapshot.docs.map((doc) => doc.id).toList();

      // Step 2: Query 'users' collection with UIDs
      QuerySnapshot usersSnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'company')
          .where(FieldPath.documentId, whereIn: validUids) // Filter by UID
          .get();

      // Return list of document snapshots
      return usersSnapshot.docs;
    });
  }
}
