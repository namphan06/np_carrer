class MyCategory {
  final int id;
  final String name;
  final String? description;

  MyCategory({
    required this.id,
    required this.name,
    this.description,
  });

  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
