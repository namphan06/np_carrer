import 'package:cloud_firestore/cloud_firestore.dart';

class JobPostModel {
  final String id;
  final String name;
  final int? minSalary;
  final int? maxSalary;
  final String? currencyUnit;
  final List<String> city;
  final String experience;
  final List<String> jobDescription;
  final List<String> requiredApplication;
  final List<String> benefits;
  final List<String> workLocation;
  final String applicationDeadline;
  final List<String> jobInterests;
  final String timeWork;

  const JobPostModel(
      {required this.id,
      required this.name,
      this.minSalary,
      this.maxSalary,
      this.currencyUnit,
      required this.city,
      required this.experience,
      required this.jobDescription,
      required this.requiredApplication,
      required this.benefits,
      required this.workLocation,
      required this.applicationDeadline,
      required this.jobInterests,
      required this.timeWork});

  factory JobPostModel.fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return JobPostModel(
        id: data['id'],
        name: data['name'],
        minSalary: data['minSalary'],
        maxSalary: data['maxSalary'],
        currencyUnit: data['currencyUnit'],
        city: List<String>.from(
          data['city'] ?? [],
        ),
        experience: data['experience'],
        jobDescription: List<String>.from(data['jobDescription'] ?? []),
        requiredApplication:
            List<String>.from(data['requiredApplication'] ?? []),
        benefits: List<String>.from(data['benefits'] ?? []),
        workLocation: List<String>.from(data['workLocation'] ?? []),
        applicationDeadline: data['applicationDeadline'],
        jobInterests: List<String>.from(
          data['jobInterests'] ?? [],
        ),
        timeWork: data['timeWork']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'minSalary': minSalary,
        'maxSalary': maxSalary,
        'currencyUnit': currencyUnit,
        'city': city,
        'experience': experience,
        'jobDescription': jobDescription,
        'requiredApplication': requiredApplication,
        'benefits': benefits,
        'workLocation': workLocation,
        'applicationDeadline': applicationDeadline,
        'jobInterests': jobInterests,
        'timeWork': timeWork,
      };
}
