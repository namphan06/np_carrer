import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';
import 'package:np_career/model/img_cloudinary.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/project.dart';
import 'package:np_career/model/skill.dart';
import 'package:np_career/model/skill_v2.dart';
import 'package:np_career/model/work_experience.dart';

class CvModelV3 {
  final String uid;
  final ImgCloudinary img;
  final String fullName;
  final String position;
  final Timestamp dateOfBirth;
  final String sex;
  final String phoneNumber;
  final String email;
  final String address;
  final String website;
  final String occupationalGoals;
  final String taste;
  final List<String> skills;
  final List<WorkExperience> workExperience;
  final List<Knowledge> knowledge;
  final List<Activity> activities;
  final List<Award> award;
  final List<Certificate> certificate;
  final List<Project> project;
  final String moreInformation;
  final String introducer;
  final String type;

  const CvModelV3({
    required this.uid,
    required this.img,
    required this.fullName,
    required this.position,
    required this.dateOfBirth,
    required this.sex,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.website,
    required this.occupationalGoals,
    required this.taste,
    required this.skills,
    required this.workExperience,
    required this.knowledge,
    required this.activities,
    required this.award,
    required this.certificate,
    required this.project,
    required this.moreInformation,
    required this.introducer,
    required this.type,
  });

  factory CvModelV3.fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;

    return CvModelV3(
      uid: snap.id,
      img: data['img'] != null
          ? ImgCloudinary.fromMap(data['img'])
          : const ImgCloudinary(
              name: '',
              id: '',
              extension: '',
              size: 0,
              url: '',
              createdAt: '',
            ),
      fullName: data['fullName'] ?? '',
      position: data['position'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      sex: data['sex'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      website: data['website'] ?? '',
      occupationalGoals: data['occupationalGoals'] ?? '',
      taste: data['taste'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
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
      project: List<Map<String, dynamic>>.from(data['project'] ?? [])
          .map((e) => Project.fromMap(e))
          .toList(),
      moreInformation: data['moreInformation'] ?? '',
      introducer: data['introducer'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img.toJson(),
      'fullName': fullName,
      'position': position,
      'dateOfBirth': dateOfBirth,
      'sex': sex,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'website': website,
      'occupationalGoals': occupationalGoals,
      'taste': taste,
      'skills': skills,
      'workExperience': workExperience.map((e) => e.toMap()).toList(),
      'knowledge': knowledge.map((e) => e.toMap()).toList(),
      'activities': activities.map((e) => e.toMap()).toList(),
      'award': award.map((e) => e.toMap()).toList(),
      'certificate': certificate.map((e) => e.toMap()).toList(),
      'project': project.map((e) => e.toMap()).toList(),
      'moreInformation': moreInformation,
      'introducer': introducer,
      'type': type
    };
  }
}
