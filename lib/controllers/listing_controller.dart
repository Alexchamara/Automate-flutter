import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/login.dart';
import '../services/auth_service.dart';
import '../models/listing.dart';
import '../config.dart';

class ListingController {
  static const String app_url = Config.APP_URL;

  static Future<void> createListing(BuildContext context, Listing listing) async {
    try {
      var response = await http.post(
        Uri.parse('$app_url/api/listings/store'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthService.instance.token}'
        },
        body: json.encode(listing.toJson()),
      );

      print("Token used in request: ${AuthService.instance.token}");
      print("Request URL: ${Uri.parse('$app_url/api/listings/store')}");
      print("Request Headers: ${{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.instance.token}',
      }}");
      print("Request Body: ${json.encode(listing.toJson())}");
      if (response.statusCode == 201) {
        print("Listing created successfully!");
      } else if (response.statusCode == 302) {
        // Follow the redirect manually
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          final redirectedResponse = await http.get(Uri.parse(redirectUrl));
          print("Redirected Response: ${redirectedResponse.body}");
          if (redirectedResponse.statusCode == 201) {
            print("Listing created successfully after redirection!");
          } else if (redirectedResponse.statusCode == 200) {
            // Check if the response is in HTML format
            if (redirectedResponse.headers['content-type']?.contains('text/html') ?? false) {
              print("Error: Received HTML response instead of JSON.");
            } else {
              print("Listing created successfully after redirection!");
            }
          } else {
            print("Error after redirection: ${redirectedResponse.statusCode} - ${redirectedResponse.body}");
          }
        } else {
          print("Redirection URL not found.");
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized! Redirecting to login.");
        Navigator.pushNamed(context, LoginPage.id);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}