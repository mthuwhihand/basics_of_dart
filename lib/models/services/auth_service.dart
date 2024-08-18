import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/iauth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();
  late final SharedPreferences _prefs;
  late final IAuthRepository _authRepository;

  static Future<AuthService> getInstance(IAuthRepository authRepository) async {
    _instance._authRepository = authRepository;
    _instance._prefs = await SharedPreferences.getInstance();
    return _instance;
  }

  //static get instance => _instance;

  static const _loggedInUserIDKey = 'mthuw_app_logged_in_ID';

  Future<ResponseResult<bool>> login(
      {required String email, required String password}) async {
    try {
      final user = await _authRepository.getUserByEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        await _prefs.setInt(_loggedInUserIDKey, user['userId']);
        return Success(true);
      } else {
        return Failure('Invalid email or password');
      }
    } catch (e) {
      return Failure('An error occurred during login: $e');
    }
  }

  Future<ResponseResult<void>> logout() async {
    try {
      await _prefs.remove(_loggedInUserIDKey);
      return Success(null); // Success with no data
    } catch (e) {
      return Failure('An error occurred during logout: $e');
    }
  }

  Future<ResponseResult<bool>> isLoggedIn() async {
    try {
      final id = _prefs.getInt(_loggedInUserIDKey);
      if (id != null) {
        return Success(true);
      } else {
        return Success(false);
      }
    } catch (e) {
      return Failure('An error occurred while checking login status: $e');
    }
  }

  Future<ResponseResult<int?>> getLoggedInUserId() async {
    try {
      final userId = _prefs.getInt(_loggedInUserIDKey);
      if (userId != null) {
        return Success(userId);
      } else {
        return Failure('No user is currently logged in');
      }
    } catch (e) {
      return Failure('An error occurred while retrieving user ID: $e');
    }
  }
}
