import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class PaymentService {
  static const _storage = FlutterSecureStorage();

  static Future<Map<String, dynamic>> createCheckoutSession(
      {required String listingId,
      String plan = 'price_1QdYo8FJ6WA2VB9nGPfkfu45'}) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        throw Exception('No auth token found');
      }

      // Change to POST request
      final response = await http.post(
        // Changed from GET to POST
        Uri.parse('${Config.APP_URL}/api/checkout/$plan'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'listing_id': listingId,
        }),
      );

      if (response.statusCode != 200) {
        print("Listing ID: $listingId");
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}");
        throw Exception('Failed to create checkout session: ${response.body}');
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create checkout session: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to create checkout session: $e');
    }
  }

  static Future<Map<String, dynamic>> verifyPayment({
    required String listingId,
    required String sessionId,
  }) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        throw Exception('No auth token found');
      }

      final response = await http.get(
        Uri.parse('${Config.APP_URL}/api/payment/success').replace(
          queryParameters: {
            'listing_id': listingId,
            'session_id': sessionId,
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Failed to verify payment: $e');
    }
  }
}
