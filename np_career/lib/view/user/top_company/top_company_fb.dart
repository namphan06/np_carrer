import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopCompanyFb {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> toggleFollowedJob({
    required String companyID,
  }) async {
    final docRef =
        _firestore.collection('user_actions').doc(_auth.currentUser!.uid);

    final docSnap = await docRef.get();
    final List<dynamic> currentFollows = docSnap.data()?['follows'] ?? [];

    if (currentFollows.contains(companyID)) {
      await docRef.update({
        'follows': FieldValue.arrayRemove([companyID])
      });
    } else {
      // Nếu chưa có thì thêm
      await docRef.set({
        'follows': FieldValue.arrayUnion([companyID])
      }, SetOptions(merge: true));
    }
  }

  Future<Map<String, List>> getFollowedCompanyStatusAndIds() async {
    final savedDoc = await _firestore
        .collection('user_actions')
        .doc(_auth.currentUser!.uid)
        .get();

    final followCompany = savedDoc.data()?['follows'] ?? [];

    final companyQuery = await _firestore.collection('users').get();
    final companyDocs = companyQuery.docs;

    List<bool> companyStatusList = [];
    List<String> companyIdList = [];

    for (var company in companyDocs) {
      final companyId = company['uid'];
      if (companyId != null) {
        final isSaved = followCompany.contains(companyId);
        companyIdList.add(companyId);
        companyStatusList.add(isSaved);
      } else {
        companyIdList.add("null");
        companyStatusList.add(false);
      }
    }
    // print(companyIdList);
    // print(companyStatusList);
    return {
      'status': companyStatusList,
      'ids': companyIdList,
    };
  }
}
