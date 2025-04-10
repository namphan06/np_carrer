class Skill {
  final String name;
  final int indicator;

  Skill({required this.name, required this.indicator});

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      name: map['name'] ?? '',
      indicator: map['indicator'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'indicator': indicator,
    };
  }
}
