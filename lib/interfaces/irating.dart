import 'package:basics_of_dart/models/rating.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class IRatingRepository {
  Future<ApiResponse<List<Rating>>> fetchRatings({required String type}) {
    // TODO: implement fetchMovies
    throw UnimplementedError();
  }

  Future<ApiResponse<List<Rating>>> searchRatings(
      {required String type, required String query}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
