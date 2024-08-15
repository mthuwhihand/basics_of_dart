import 'dart:convert';
import 'package:basics_of_dart/interfaces/iauth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  // Private constructor
  AuthRepository._();

  // Singleton instance
  static final AuthRepository _instance = AuthRepository._();

  static get instance => _instance;

  static const _loggedInEmailKey = 'mthuw_app_logged_in_email';

  @override
  Future<bool> login({required String email, required String password}) async {
    // Read JSON from assets
    final String response =
        await rootBundle.loadString('assets/mocks/mock_users.json');
    final List<dynamic> data = json.decode(response);

    // Check email and password
    for (var user in data) {
      if (user['email'] == email && user['password'] == password) {
        // Save email using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_loggedInEmailKey, email);
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> logout() async {
    // Remove saved email
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInEmailKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_loggedInEmailKey);
    return email != null && email.isNotEmpty;
  }
}
