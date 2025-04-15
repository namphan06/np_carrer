import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:np_career/model/work_experience.dart';

class MyProfileModel {
  final String fullName;
  final String phoneNumber;
  final String address;
  final String nationality;
  final String educationLevel;
  final Timestamp dateOfBirth;
  final String sex;
  final String hiringReason;
  final List<WorkExperience> workExperience;
  final List<String> preferredJobType;
  final List<String> jobInterests;
  final bool securitySetting;
  final String resumePosition;
  final String resumeType;
  final String resumeId;

  const MyProfileModel({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.nationality,
    required this.educationLevel,
    required this.dateOfBirth,
    required this.sex,
    required this.hiringReason,
    required this.workExperience,
    required this.preferredJobType,
    required this.jobInterests,
    required this.securitySetting,
    required this.resumePosition,
    required this.resumeType,
    required this.resumeId,
  });

  factory MyProfileModel.fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return MyProfileModel(
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      nationality: data['nationality'] ?? '',
      educationLevel: data['educationLevel'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? Timestamp.now(),
      sex: data['sex'] ?? '',
      hiringReason: data['hiringReason'] ?? '',
      workExperience:
          List<Map<String, dynamic>>.from(data['workExperience'] ?? [])
              .map((e) => WorkExperience.fromMap(e))
              .toList(),
      preferredJobType: List<String>.from(data['preferredJobType'] ?? []),
      jobInterests: List<String>.from(data['jobInterests'] ?? []),
      securitySetting: data['securitySetting'] ?? false,
      resumePosition: data['resumePosition'] ?? '',
      resumeType: data['resumeType'] ?? '',
      resumeId: data['resumeId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'nationality': nationality,
      'educationLevel': educationLevel,
      'dateOfBirth': dateOfBirth,
      'sex': sex,
      'hiringReason': hiringReason,
      'workExperience': workExperience.map((e) => e.toMap()).toList(),
      'preferredJobType': preferredJobType,
      'jobInterests': jobInterests,
      'securitySetting': securitySetting,
      'resumePosition': resumePosition,
      'resumeType': resumeType,
      'resumeId': resumeId,
    };
  }
}
