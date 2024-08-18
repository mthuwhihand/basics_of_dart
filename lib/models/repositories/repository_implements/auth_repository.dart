import 'dart:convert';
import 'package:basics_of_dart/models/repositories/repository_interfaces/iauth_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthRepository implements IAuthRepository {
  // Private constructor
  AuthRepository._();

  // Singleton instance
  static final AuthRepository _instance = AuthRepository._();

  static get instance => _instance;

  static const _loggedInUserIDKey = 'mthuw_app_logged_in_ID';

  @override
  Future<dynamic> getUserByEmailAndPassword(
      {required String email, required String password}) async {
    // Read JSON from assets
    final String response =
        await rootBundle.loadString('assets/mocks/mock_users.json');
    final List<dynamic> data = json.decode(response);

    // Check email and password
    for (var user in data) {
      if (user['email'] == email && user['password'] == password) {
        return user;
      }
    }
    return null;
  }
}
