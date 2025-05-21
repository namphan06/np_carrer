class Project {
  final String name;
  final String customer;
  final String describe;
  final String quality;
  final String position;
  final List<String> role;
  final String technology;

  Project({
    required this.name,
    required this.customer,
    required this.describe,
    required this.quality,
    required this.position,
    required this.role,
    required this.technology,
  });

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'] ?? '',
      customer: map['customer'] ?? '',
      describe: map['describe'] ?? '',
      quality: map['quality'] ?? '',
      position: map['position'] ?? '',
      role: List<String>.from(map['role'] ?? []),
      technology: map['technology'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'customer': customer,
      'describe': describe,
      'quality': quality,
      'position': position,
      'role': role,
      'technology': technology,
    };
  }
}
