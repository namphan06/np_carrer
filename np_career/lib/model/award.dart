class Award {
  final String name;
  final String date;

  Award({required this.name, required this.date});

  factory Award.fromMap(Map<String, dynamic> map) {
    return Award(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
    };
  }
}
