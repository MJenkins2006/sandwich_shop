import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  String? _name;
  String? _email;
  String? _password;

  String? get currentUserName => _name;

  bool get isSignedIn => _name != null;

  Future<bool> signUp(String name, String email, String password) async {
    // Basic validation
    if (name.isEmpty || email.isEmpty || password.length < 6) {
      return false;
    }

    // Store in-memory (mock)
    _name = name;
    _email = email;
    _password = password;

    // emulate async work
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (_email == null) return false;
    if (email == _email && password == _password) {
      return true;
    }
    return false;
  }

  void signOut() {
    _name = null;
    _email = null;
    _password = null;
  }
}
