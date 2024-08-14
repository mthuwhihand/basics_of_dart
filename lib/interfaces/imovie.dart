import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class IMovieRepository {
  static String baseUrl = 'https://api.sampleapis.com/movies/';

  Future<ApiResponse<List<Movie>>> fetchMovies({required String type}) {
    // TODO: implement fetchMovies
    throw UnimplementedError();
  }

  Future<ApiResponse<List<Movie>>> searchMovies(
      {required String type, required String query}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
