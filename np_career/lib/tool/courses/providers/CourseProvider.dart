import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:np_career/model/course.dart';
import 'package:np_career/model/enrollment.dart';
import 'package:np_career/services/call_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseProvider extends ChangeNotifier {
  final AppService apiService;
  final int categoryId;

  List<Course> courses = [];
  bool _isFirstLoad = true;
  Timer? _timer;

  // Map courseId -> đã đăng ký (true/false)
  Map<int, int> enrollmentStatus = {};

  CourseProvider({
    required this.apiService,
    required this.categoryId,
  }) {
    init();
    _startPolling();
  }

  Future<void> init() async {
    await _fetchCoursesAndEnrollments();
    _isFirstLoad = false;
    notifyListeners();
  }

  Future<void> _fetchCoursesAndEnrollments() async {
    courses = await apiService.fetchCoursesByCategoryId(categoryId);

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      for (var course in courses) {
        var enrollments =
            await apiService.fetchEnrollmentsByCourseId(course.id!);

        // Tìm enrollment của user với course này
        Enrollment? enrollment;
        try {
          enrollment = enrollments.firstWhere((e) => e.userId == userId);
        } catch (e) {
          enrollment = null;
        }

        int statusCode;
        if (enrollment == null) {
          statusCode = 1; // Không tìm thấy
        } else if (enrollment.status.toLowerCase() == 'active') {
          statusCode = 3; // Active
        } else {
          statusCode = 2; // Inactive
        }

        enrollmentStatus[course.id!] = statusCode;
      }
    }
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _fetchCoursesAndEnrollments();
      notifyListeners();
    });
  }

  bool get isLoading => _isFirstLoad && courses.isEmpty;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
