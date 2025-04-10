class WorkExperience {
  final String company;
  final String date;
  final String position;
  final List<String> list;

  WorkExperience({
    required this.company,
    required this.date,
    required this.position,
    required this.list,
  });

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      company: map['company'] ?? '',
      date: map['date'] ?? '',
      position: map['position'] ?? '',
      list: List<String>.from(map['list'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'date': date,
      'position': position,
      'list': list,
    };
  }
}
