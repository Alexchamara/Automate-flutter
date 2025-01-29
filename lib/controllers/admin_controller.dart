import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../config.dart';
import '../models/listing.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AdminController {
  // Fetch all listings
  static Future<List<Listing>> getAllListings() async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/listings/all');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('data')) {
          List<dynamic> listingsJson = jsonResponse['data'];
          return listingsJson.map((data) => Listing.fromJson(data)).toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  // Approve an advert
  static Future<void> approveAdvert(int listingId) async {
    try {
      final uri =
          Uri.parse('${Config.APP_URL}/api/admin/listings/$listingId/accept');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Advert approved successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Reject an advert
  static Future<void> rejectAdvert(int listingId) async {
    try {
      final uri =
          Uri.parse('${Config.APP_URL}/api/admin/listings/$listingId/reject');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Advert rejected successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Toggle advert active status
  static Future<void> updateAdvertActive(int listingId, bool isApproved) async {
    try {
      final uri = Uri.parse(
          '${Config.APP_URL}/api/admin/listings/$listingId/${isApproved ? 'accept' : 'reject'}');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Advert ${isApproved ? 'approved' : 'rejected'} successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Fetch all users excluding admins
  static Future<List<User>> getAllUsersExcludingAdmins() async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/users');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return jsonResponse
              .map((data) => User.fromJson(data))
              .where((user) => user.role != 'Admin')
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  // Activate a user
  static Future<void> activateUser(int userId) async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/users/$userId/activate');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("User activated successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Deactivate a user
  static Future<void> deactivateUser(int userId) async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/users/$userId/deactivate');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("User deactivated successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
