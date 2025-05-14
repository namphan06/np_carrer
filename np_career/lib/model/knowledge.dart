class Knowledge {
  final String school;
  final String date;
  final String? name;
  final List<String> list;

  Knowledge(
      {required this.school,
      required this.date,
      required this.list,
      this.name});

  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
        school: map['school'] ?? '',
        date: map['date'] ?? '',
        list: List<String>.from(map['list'] ?? []),
        name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'school': school, 'date': date, 'list': list, 'name': name};
  }
}
