class Certificate {
  final String name;
  final String date;

  Certificate({required this.name, required this.date});

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
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
