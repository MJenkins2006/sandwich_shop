import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  // Registered user (persisted in-memory for mock)
  String? _registeredName;
  String? _registeredEmail;
  String? _registeredPassword;

  // Currently signed-in user's display name (null when signed out)
  String? _name;

  String? get currentUserName => _name;

  bool get isSignedIn => _name != null;

  Future<bool> signUp(String name, String email, String password) async {
    // Basic validation
    if (name.isEmpty || email.isEmpty || password.length < 6) {
      return false;
    }

    // Store in-memory (mock) as registered user and sign them in
    _registeredName = name;
    _registeredEmail = email;
    _registeredPassword = password;
    _name = name;

    // emulate async work
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (_registeredEmail == null) return false;
    if (email == _registeredEmail && password == _registeredPassword) {
      // restore signed-in state
      _name = _registeredName;
      return true;
    }
    return false;
  }

  void signOut() {
    // keep registered credentials, just clear signed-in session
    _name = null;
  }
}
