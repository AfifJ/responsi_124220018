import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:responsi_124220018/models/data_model.dart';

class ApiHelper {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<dynamic>> getCategories(
      {String endpoint = '/categories.php'}) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        List<dynamic> data = body['categories'];
        return data;
      } else {
        throw Exception('Gagal meng fetch $endpoint');
      }
    } catch (e) {
      throw Exception('Error fetching: $e');
    }
  }

  static Future<List<dynamic>> getMeals(String category) async {
    String baseEnd = '/filter.php?c=';
    String endpoint = baseEnd + category;
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        List<dynamic> data = body['meals'];
        return data;
      } else {
        throw Exception('Gagal meng fetch $endpoint');
      }
    } catch (e) {
      throw Exception('Error fetching: $e');
    }
  }

  static Future<dynamic> getDetails(String id) async {
    String baseEnd = '/lookup.php?i=';
    String endpoint = baseEnd + id;
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        dynamic data = body['meals'];
        return data;
      } else {
        throw Exception('Gagal meng fetch $endpoint');
      }
    } catch (e) {
      throw Exception('Error fetching: $e');
    }
  }
}
