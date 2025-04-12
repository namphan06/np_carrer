class Skill {
  final String name;
  final int indicator;

  Skill({required this.name, required this.indicator});

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      name: map['name'] ?? '',
      indicator: int.tryParse(map['indicator'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'indicator': indicator,
    };
  }
}
