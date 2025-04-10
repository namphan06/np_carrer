class Activity {
  final String name;
  final String date;
  final String position;
  final List<String> list;

  Activity({
    required this.name,
    required this.date,
    required this.position,
    required this.list,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      position: map['position'] ?? '',
      list: List<String>.from(map['list'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'position': position,
      'list': list,
    };
  }
}
