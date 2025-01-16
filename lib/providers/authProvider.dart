import 'package:automate/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  User _user = User(id: 0, name: '', email: '', token: '', role: '');

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    const storage = FlutterSecureStorage();
    String? name = await storage.read(key: "name");
    String? email = await storage.read(key: "email");
    String? token = await storage.read(key: "auth_token");
    _user = User(id: 0, name: '', email: '', token: '', role: '');
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
  }

  void logOut() {
    _user = User(id: 0, name: '', email: '', token: '', role: '');
  }

  User getUser() {
    return _user;
  }

  bool authenticated() {
    return _user.token != null ? true : false;
  }
}
