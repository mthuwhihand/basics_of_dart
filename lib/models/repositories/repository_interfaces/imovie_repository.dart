import 'package:basics_of_dart/models/entities/movie.dart';

interface class IMovieRepository {
  static const String baseUrl = 'https://api.sampleapis.com/movies/animation';

  Future<List<Movie>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  // Future<List<Movie>> search({required String query}) {
  //   // TODO: implement search
  //   throw UnimplementedError();
  // }
}
