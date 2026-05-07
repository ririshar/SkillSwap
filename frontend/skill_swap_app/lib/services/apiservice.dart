import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<List<dynamic>> getListings() async {
    final response = await http.get(Uri.parse('$baseUrl/listings/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  static Future<void> createListing({
    required String title,
    required String description,
    required String level,
    required String availability,
    double price = 0,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/listings/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'price': price,
        'level': level,
        'availability': availability,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create listing');
    }
  }
}