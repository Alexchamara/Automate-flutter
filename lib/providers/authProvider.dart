import 'package:automate/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User _user = User(id: 0, name: '', email: '', mobile: '', token: '', role: '');

  bool _isAuthenticated = false;
  String _token = "";

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    const storage = FlutterSecureStorage();
    String? name = await storage.read(key: "name");
    String? email = await storage.read(key: "email");
    String? mobile = await storage.read(key: "mobile");
    String? token = await storage.read(key: "auth_token");
    String? role = await storage.read(key: "role");
    _user = User(
        id: 0,
        name: name ?? '',
        email: email ?? '',
        mobile: mobile ?? '',
        token: token ?? '',
        role: role ?? '');
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void login(String token) {
    _token = token;
    _user = User(
      id: _user.id,
      name: _user.name,
      email: _user.email,
      mobile: _user.mobile,
      token: token,
      role: _user.role,
    );
    _isAuthenticated = true;
    AuthService.instance.setToken(token);
    notifyListeners();
  }

  // void logout() {
  //   _token = "";
  //   _isAuthenticated = false;
  //   AuthService.instance.setToken("");
  //   notifyListeners();
  // }

  Future<void> logOut() async {
    try {
      await Auth.logout();
      _user = User(id: 0, name: '', email: '', mobile: '', token: '', role: '');
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  User getUser() {
    return _user;
  }

  String getUserRole() {
    return _user.role;
  }

  bool authenticated() {
    return _user.token.isNotEmpty;
  }
}
