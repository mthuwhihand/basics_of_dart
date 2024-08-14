import 'package:basics_of_dart/models/user.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class IUserRepository {
  Future<ApiResponse<List<User>>> fetchUsers({required String type}) {
    // TODO: implement fetchMovies
    throw UnimplementedError();
  }

  Future<ApiResponse<List<User>>> searchUsers(
      {required String type, required String query}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
