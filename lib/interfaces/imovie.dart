import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';

abstract class IMovieRepository {
  static String baseUrl = 'https://api.sampleapis.com/movies/';

  Future<ApiResponse<List<Movie>>> fetchMovies({required String type}) {
    // TODO: implement fetchMovies
    throw UnimplementedError();
  }
}
