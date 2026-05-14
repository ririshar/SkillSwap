import 'dart:convert';
import 'package:http/http.dart' as http;

// This file handles the connection between the Flutter app and the backend API
class ApiService {
  // Base URL for the FastAPI backend
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Gets all listings from the backend
  static Future<List<dynamic>> getListings() async {
    final response = await http.get(Uri.parse('$baseUrl/listings/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load listings');
    }
  }

  // Sends a new listing to the backend
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

  // Sends a new lesson request to the backend
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

  // Gets all lesson requests from the backend
  static Future<List<dynamic>> getRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/requests/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load requests');
    }
  }

  // Updates a request status to accepted
  static Future<void> acceptRequest(int requestId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/requests/$requestId/accept'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to accept request');
    }
  }

  // Updates a request status to rejected
  static Future<void> rejectRequest(int requestId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/requests/$requestId/reject'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject request');
    }
  }

  // Deletes a request from the backend
  static Future<void> deleteRequest(int requestId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/requests/$requestId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete request');
    }
  }

  // Deletes a listing from the backend
  static Future<void> deleteListing(int listingId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/listings/$listingId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete listing');
    }
  }
}
