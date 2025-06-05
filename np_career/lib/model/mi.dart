class Mi {
  final int id;
  final String title;
  final String type;

  Mi({
    required this.id,
    required this.title,
    required this.type,
  });

  // Hàm fromMap để convert từ JSON thành object Mi
  factory Mi.fromMap(Map<String, dynamic> map) {
    return Mi(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      type: map['type'] ?? '',
    );
  }

  // (Tùy chọn) Hàm toMap nếu bạn muốn convert object sang JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
    };
  }
}
