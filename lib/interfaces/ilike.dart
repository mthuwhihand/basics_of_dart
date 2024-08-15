import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class ILikeRepository {
  static String baseUrl = 'https://api.sampleapis.com/movies/';

  Future<ApiResponse<List<Movie>>> fetchLikes(
      // ignore: non_constant_identifier_names
      {required String type,
      required int user_id}) {
    throw UnimplementedError();
  }

  Future<ApiResponse<void>> addLike(
      // ignore: non_constant_identifier_names
      {required int user_id,
      // ignore: non_constant_identifier_names
      required int movie_id}) {
    throw UnimplementedError();
  }
}
