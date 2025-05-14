import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/skill.dart';
import 'package:np_career/model/skill_v2.dart';
import 'package:np_career/model/work_experience.dart';

class CvModelV2 {
  final String uid;
  final String linkImage;
  final String fullName;
  final String position;
  final String phoneNumber;
  final String email;
  final String address;
  final String website;
  final String occupationalGoals;
  final List<SkillV2> skills;
  final List<WorkExperience> workExperience;
  final List<Knowledge> knowledge;
  final List<Activity> activities;
  final List<Award> award;
  final List<Certificate> certificate;
  final String moreInformation;
  final String introducer;
  final String type;

  const CvModelV2({
    required this.uid,
    required this.linkImage,
    required this.fullName,
    required this.position,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.website,
    required this.occupationalGoals,
    required this.skills,
    required this.workExperience,
    required this.knowledge,
    required this.activities,
    required this.award,
    required this.certificate,
    required this.moreInformation,
    required this.introducer,
    required this.type,
  });

  factory CvModelV2.fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return CvModelV2(
      uid: snap.id,
      linkImage: data['linkImage'] ?? '',
      fullName: data['fullName'] ?? '',
      position: data['position'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      website: data['website'] ?? '',
      occupationalGoals: data['occupationalGoals'] ?? '',
      skills: List<Map<String, dynamic>>.from(data['skills'] ?? [])
          .map((e) => SkillV2.fromMap(e))
          .toList(),
      workExperience:
          List<Map<String, dynamic>>.from(data['workExperience'] ?? [])
              .map((e) => WorkExperience.fromMap(e))
              .toList(),
      knowledge: List<Map<String, dynamic>>.from(data['knowledge'] ?? [])
          .map((e) => Knowledge.fromMap(e))
          .toList(),
      activities: List<Map<String, dynamic>>.from(data['activities'] ?? [])
          .map((e) => Activity.fromMap(e))
          .toList(),
      award: List<Map<String, dynamic>>.from(data['award'] ?? [])
          .map((e) => Award.fromMap(e))
          .toList(),
      certificate: List<Map<String, dynamic>>.from(data['certificate'] ?? [])
          .map((e) => Certificate.fromMap(e))
          .toList(),
      moreInformation: data['moreInformation'] ?? '',
      introducer: data['introducer'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'linkImage': linkImage,
      'fullName': fullName,
      'position': position,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'website': website,
      'occupationalGoals': occupationalGoals,
      'skills': skills.map((e) => e.toMap()).toList(),
      'workExperience': workExperience.map((e) => e.toMap()).toList(),
      'knowledge': knowledge.map((e) => e.toMap()).toList(),
      'activities': activities.map((e) => e.toMap()).toList(),
      'award': award.map((e) => e.toMap()).toList(),
      'certificate': certificate.map((e) => e.toMap()).toList(),
      'moreInformation': moreInformation,
      'introducer': introducer,
      'type': type
    };
  }
}
