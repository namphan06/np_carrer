import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:np_career/model/category.dart';
import 'package:np_career/model/course.dart';
import 'package:np_career/model/enrollment.dart';

class AppService {
  final String baseUrl = 'http://192.168.0.104:8000/api';

  Future<List<MyCategory>> fetchCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse(baseUrl + '/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the response body as a string
        String? responseBody = response.body;

        // Check if the response body is not null and not empty
        if (responseBody != null && responseBody.isNotEmpty) {
          // Decode the JSON response
          List<dynamic> jsonResponse = jsonDecode(responseBody);

          // Ensure that jsonResponse is a list
          if (jsonResponse is List) {
            // Map each element to a Category object
            List<MyCategory> categories = jsonResponse
                .map((category) => MyCategory.fromMap(category))
                .toList();

            // Return the list of categories
            return categories;
          } else {
            // Handle the case where the JSON response is not a list
            print(
                'Unexpected JSON format. Expected a list under "categories".');
            return [];
          }
        } else {
          // Handle the case where the response body is empty or null
          print('Empty or null response body.');
          return [];
        }
      } else {
        // Handle non-200 status code if needed
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      // Handle exceptions during the HTTP request
      print('Error during HTTP request: $e');
      return [];
    }
  }

  Future<List<Course>> fetchCoursesByCategoryId(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories/show/$categoryId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('courses')) {
          List<dynamic> coursesJson = data['courses'];

          List<Course> courses = coursesJson
              .map((courseJson) => Course.fromMap(courseJson))
              .toList();

          return courses;
        } else {
          print('Response JSON does not contain "courses" key.');
          return [];
        }
      } else {
        print('Failed to fetch courses. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      return [];
    }
  }

  Future<bool> enrollCourse({
    required String userId,
    required int courseId,
    String? note,
    String status = 'inactive',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/enrollments'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'course_id': courseId,
          'note': note,
          'status': status,
        }),
      );

      if (response.statusCode == 201) {
        // Đăng ký thành công
        return true;
      } else {
        print('Failed to enroll course. Status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error enrolling course: $e');
      return false;
    }
  }

  Future<List<Enrollment>> fetchEnrollmentsByCourseId(int courseId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses/$courseId/enrollments'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('enrollments')) {
          List<dynamic> enrollmentsJson = data['enrollments'];

          List<Enrollment> enrollments =
              enrollmentsJson.map((e) => Enrollment.fromMap(e)).toList();

          return enrollments;
        } else {
          print('Response JSON không có khóa "enrollments"');
          return [];
        }
      } else {
        print(
            'Failed to fetch enrollments. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching enrollments: $e');
      return [];
    }
  }
}
