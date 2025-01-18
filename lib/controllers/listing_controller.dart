import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/login.dart';
import '../services/auth_service.dart';
import '../models/listing.dart';
import '../config.dart';
import 'package:http/http.dart' as http;


class ListingController{

  static Future<void> createListing(BuildContext context, Listing listing) async {
    try {
      final uri = Uri.parse('${Config.APP_URL}/api/listings/store');
     final request = http.MultipartRequest('POST', uri)
  ..headers['Content-Type'] = 'application/json'
  ..headers['Accept'] = 'application/json'
  ..headers['Authorization'] = 'Bearer ${AuthService.instance.token}'
  ..fields.addAll(listing.toJson().map((key, value) => MapEntry(key, value.toString())));

      // Attach image files
      if (listing.images != null) {
        for (var imageFile in listing.images!) {
          request.files.add(await http.MultipartFile.fromPath(
            'images[]', // Match this name with the backend field
            imageFile.path,
          ));
        }
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        print("Listing created successfully!");
      } else {
        final responseBody = await response.stream.bytesToString();
        print("Error: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      print("Exception: $e");
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