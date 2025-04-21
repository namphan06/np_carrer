import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCompanyModel {
  final String website;
  final String headcount;
  final String address;
  final String? facebook;
  final String? twitter;
  final String? linkedIn;
  final String preview;

  const ProfileCompanyModel({
    required this.website,
    required this.headcount,
    required this.address,
    this.facebook,
    this.linkedIn,
    this.twitter,
    required this.preview,
  });

  factory ProfileCompanyModel.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return ProfileCompanyModel(
      website: data['website'] ?? '',
      headcount: data['headcount'] ?? '',
      address: data['address'] ?? '',
      facebook: data['facebook'],
      twitter: data['twitter'],
      linkedIn: data['linkedIn'],
      preview: data['preview'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'website': website,
      'headcount': headcount,
      'address': address,
      'facebook': facebook,
      'twitter': twitter,
      'linkedIn': linkedIn,
      'preview': preview,
    };
  }
}
