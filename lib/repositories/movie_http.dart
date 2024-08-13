import 'dart:convert';
import 'dart:io';
import 'package:basics_of_dart/interfaces/imovie.dart';
import 'package:basics_of_dart/network/response.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class HTTPMovieRepository extends IMovieRepository {
  final http.Client client = http.Client();

  @override
  Future<ApiResponse<List<Movie>>> fetchMovies({required String type}) async {
    String baseUrl = IMovieRepository.baseUrl;
    try {
      final response = await client.get(Uri.parse('$baseUrl$type'));
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> moviesJson = json.decode(response.body);
        List<Movie> movies =
            moviesJson.map((json) => Movie.fromJson(json)).toList();
        return ApiResponse.responseBuilder('Successful', movies, HttpStatus.ok);
      } else {
        return ApiResponse.responseBuilder(
            'Failed', null, HttpStatus.expectationFailed);
      }
    } catch (e) {
      return ApiResponse.responseBuilder(
          'An error occurred: $e', null, HttpStatus.networkConnectTimeoutError);
    }
  }
}
