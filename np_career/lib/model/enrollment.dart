class Enrollment {
  final int id;
  final String userId;
  final int courseId;
  final String? note;
  final String status;
  final DateTime registeredAt;

  Enrollment({
    required this.id,
    required this.userId,
    required this.courseId,
    this.note,
    required this.status,
    required this.registeredAt,
  });

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      id: map['id'],
      userId: map['user_id'],
      courseId: map['course_id'],
      note: map['note'],
      status: map['status'],
      registeredAt: DateTime.parse(map['registered_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'course_id': courseId,
      'note': note,
      'status': status,
      'registered_at': registeredAt.toIso8601String(),
    };
  }
}
