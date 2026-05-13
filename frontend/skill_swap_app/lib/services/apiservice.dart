import 'dart:convert';
import 'package:http/http.dart' as http;
// this file defines the ApiService class, which contains static methods for making HTTP requests to the backend API.
// It includes methods for fetching listings and requests, creating new listings and requests, and updating or deleting existing requests and listings. The ApiService class abstracts away the details of making HTTP requests and provides a simple interface for the rest of the app to interact with the backend API.
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
    required String contact,
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
        'contact': contact,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create listing: ${response.body}');
    }
  }

  static Future<void> createRequest({
    required int listingId,
    required String requesterName,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/requests/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'listing_id': listingId,
        'requester_name': requesterName,
        'message': message,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create request');
    }
  }

  static Future<List<dynamic>> getRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/requests/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load requests');
    }
  }
  static Future<void> acceptRequest(int requestId) async {
  final response = await http.put(
    Uri.parse('$baseUrl/requests/$requestId/accept'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to accept request');
  }
}

static Future<void> rejectRequest(int requestId) async {
  final response = await http.put(
    Uri.parse('$baseUrl/requests/$requestId/reject'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to reject request');
  }
}

static Future<void> deleteRequest(int requestId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/requests/$requestId'),
  );

  if (response.statusCode != 204) {
    throw Exception('Failed to delete request');
  }
 }

 static Future<void> deleteListing(int listingId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/listings/$listingId'),
  );

  if (response.statusCode != 204) {
    throw Exception('Failed to delete listing');
  }
 }
}
