import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/advert.dart';
import '../screens/login.dart';
import '../services/auth_service.dart';
import '../models/listing.dart';
import '../config.dart';
import 'package:http/http.dart' as http;

class ListingController {
  static final StreamController<String> _statusController = StreamController<String>.broadcast();

  static Stream<String> get statusStream => _statusController.stream;

  static void updateStatus(String status) {
    _statusController.add(status);
  }

  //Create a new listing
  static Future<Map<String, dynamic>> createListing(BuildContext context, Advert advert) async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/listings/store');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..headers['Accept'] = 'application/json'
        ..headers['Authorization'] = 'Bearer ${AuthService.instance.token}'
        ..fields.addAll(advert
            .toJson()
            .map((key, value) => MapEntry(key, value.toString())));

      // Attach image files
      if (advert.images != null) {
        for (var imageFile in advert.images!) {
          final file = File(imageFile);
          request.files.add(await http.MultipartFile.fromPath(
            'images[]', // Match this name with the backend field
            file.path,
          ));
        }
      }

      final response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        final responseBody = await response.stream.bytesToString();
        print("Error: ${response.statusCode} - $responseBody");
        throw Exception('Failed to create listing');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to create listing');
    }
  }

  // Fetch listings related to the authenticated user
  static Future<List<Listing>> getUserListings() async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/user/listings');
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

  // Update the status of an advert
  static Future<void> updateAdvertStatus(int advertId, bool isActive) async {
    try {
      final uri =
          Uri.parse('${Config.APP_URL}/api/listings/$advertId/toggle-status');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
        body: json.encode({'isActive': isActive}),
      );

      // print the advertID
      print("Advert ID: $advertId");

      if (response.statusCode == 200) {
        print("Advert status updated successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Delete an advert
  static Future<void> deleteListing(int listingId) async {
    try {
      final uri =
          Uri.parse('${Config.APP_URL}/api/listings/destroy/$listingId');
      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Listing deleted successfully!");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Fetch all listings
  static Future<List<Listing>> getAllListings() async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/listings');
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
            jsonResponse.containsKey('data') &&
            jsonResponse['data'] is Map<String, dynamic> &&
            jsonResponse['data'].containsKey('data')) {
          List<dynamic> listingsJson = jsonResponse['data']['data'];
          return listingsJson.map((data) => Listing.fromJson(data)).toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception('Failed to load listings');
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }
}

// class ListingController {
//   static const String app_url = Config.APP_URL;
//
//   static Future<void> createListing(BuildContext context, Listing listing) async {
//     try {
//       var response = await http.post(
//         Uri.parse('$app_url/api/listings/store'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${AuthService.instance.token}'
//         },
//         body: json.encode(listing.toJson()),
//       );
//
//       // Print the response for debugging
//       print("Token used in request: ${AuthService.instance.token}");
//       print("Request URL: ${Uri.parse('$app_url/api/listings/store')}");
//       print("Request Headers: ${{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${AuthService.instance.token}',
//       }}");
//       print("Request Body: ${json.encode(listing.toJson())}");
//       if (response.statusCode == 201) {
//         print("Listing created successfully!");
//       } else if (response.statusCode == 302) {
//         // Follow the redirect manually
//         final redirectUrl = response.headers['location'];
//         if (redirectUrl != null) {
//           final redirectedResponse = await http.get(Uri.parse(redirectUrl));
//           print("Redirected Response: ${redirectedResponse.body}");
//           if (redirectedResponse.statusCode == 201) {
//             print("Listing created successfully after redirection!");
//           } else if (redirectedResponse.statusCode == 200) {
//             // Check if the response is in HTML format
//             if (redirectedResponse.headers['content-type']?.contains('text/html') ?? false) {
//               print("Error: Received HTML response instead of JSON.");
//             } else {
//               print("Listing created successfully after redirection!");
//             }
//           } else {
//             print("Error after redirection: ${redirectedResponse.statusCode} - ${redirectedResponse.body}");
//           }
//         } else {
//           print("Redirection URL not found.");
//         }
//       } else if (response.statusCode == 401) {
//         print("Unauthorized! Redirecting to login.");
//         Navigator.pushNamed(context, LoginPage.id);
//       } else {
//         print("Error: ${response.statusCode} - ${response.body}");
//       }
//     } catch (e) {
//       print("Exception: $e");
//     }
//   }
// }
