class Knowledge {
  final String school;
  final String date;
  final List<String> list;

  Knowledge({
    required this.school,
    required this.date,
    required this.list,
  });

  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
      school: map['school'] ?? '',
      date: map['date'] ?? '',
      list: List<String>.from(map['list'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'school': school,
      'date': date,
      'list': list,
    };
  }
}
