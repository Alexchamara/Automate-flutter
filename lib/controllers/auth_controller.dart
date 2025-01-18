import 'dart:convert';
import 'dart:io';

import 'package:automate/config.dart';
import 'package:automate/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/auth_service.dart';

class Auth {
  static const String app_url = Config.APP_URL;

  //log in function
  static Future<User> login(String email, String password) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    var response = await http.post(
      Uri.parse('$app_url/api/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        "device_name": deviceInfo.model,
      }),
    );

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      const storage = FlutterSecureStorage();
      var user = jsonResponse["user"];
      await storage.write(key: "name", value: user["name"]);
      await storage.write(key: "email", value: user["email"]);
      await storage.write(key: "auth_token", value: jsonResponse["token"]);
      await storage.write(key: "role", value: user["role"]);
      AuthService.instance.setToken(jsonResponse["token"]);
      return User(
        id: user["id"],
        name: user["name"],
        email: user["email"],
        token: jsonResponse["token"],
        role: user["role"],
      );
    }

    if (response.statusCode == 302) {
      // Follow the redirect manually
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final redirectedResponse = await http.get(Uri.parse(redirectUrl));
        print("Redirected Response: ${redirectedResponse.body}");
        return User.fromJson(json.decode(redirectedResponse.body)['user']);
      }
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse['user']); // Extract user details
    } else if (response.statusCode == 401) {
      throw Exception("Incorrect password");
    } else if (response.statusCode == 404) {
      throw Exception("Invalid email");
    } else if (response.statusCode == 422) {
      throw Exception("Invalid email or password");
    } else if (response.statusCode == 500) {
      throw Exception("Server error");
    } else {
      print("Response: ${response.body}");
      throw Exception("Login failed with status: ${response.statusCode}");
    }
  }

  //log out function
  static Future<void> logout() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "auth_token");

    if (token == null) {
      print("No auth token found");
      return;
    }

    var response = await http.post(
      Uri.parse('$app_url/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await storage.delete(key: "name");
      await storage.delete(key: "email");
      await storage.delete(key: "auth_token");
      await storage.delete(key: "role");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Invalid token");
    } else {
      throw Exception("Logout failed with status: ${response.statusCode}");
    }
  }

  //register function
  static Future<User> register(String name, String email, String password, String confirmPassword) async {
    var response = await http.post(
      Uri.parse('$app_url/api/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      const storage = FlutterSecureStorage();
      var user = jsonResponse["user"];
      await storage.write(key: "name", value: user["name"]);
      await storage.write(key: "email", value: user["email"]);
      await storage.write(key: "auth_token", value: jsonResponse["token"]);
      await storage.write(key: "role", value: user["role"]);
      return User.fromJson(user);
    } else if (response.statusCode == 422) {
      throw ("Validation error: ${response.body}");
    } else {
      throw ("Registration failed with status: ${response.statusCode}");
    }
  }
}
