import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:np_career/model/category.dart';

class AppService {
  final String baseUrl = 'http://192.168.0.104:8000/api/';

  Future<List<MyCategory>> fetchCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'categories'),
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
}
