import 'package:basics_of_dart/models/like.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class ILikeRepository {
  static String baseUrl = 'https://api.sampleapis.com/movies/';

  Future<ApiResponse<List<Like>>> fetchLikes({required String type}) {
    // TODO: implement fetchMovies
    throw UnimplementedError();
  }

  Future<ApiResponse<List<Like>>> searchLikes(
      {required String type, required String query}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
