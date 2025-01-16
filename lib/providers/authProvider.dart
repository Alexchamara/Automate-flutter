import 'package:automate/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controllers/auth_controller.dart';

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
    String? role = await storage.read(key: "role");
    _user = User(
        id: 0,
        name: name ?? '',
        email: email ?? '',
        token: token ?? '',
        role: role ?? '');
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      await Auth.logout();
      _user = User(id: 0, name: '', email: '', token: '', role: '');
      notifyListeners();
    } catch (e) {
      print(e);
      throw e; // Re-throw the exception to handle it in the UI
    }
  }

  User getUser() {
    return _user;
  }

  bool authenticated() {
    return _user.token.isNotEmpty;
  }
}
