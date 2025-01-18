class AuthService {
  static final AuthService instance = AuthService._internal();
  String _token = "";

  AuthService._internal();

  void setToken(String newToken) {
    _token = newToken;
  }

  String get token => _token;
}