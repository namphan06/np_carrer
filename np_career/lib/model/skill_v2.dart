class SkillV2 {
  final String name;
  final List<String> list;

  SkillV2({
    required this.name,
    required this.list,
  });

  factory SkillV2.fromMap(Map<String, dynamic> map) {
    return SkillV2(
      name: map['name'] ?? '',
      list: List<String>.from(map['list'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'list': list,
    };
  }
}
