import 'dart:io';
import 'package:basics_of_dart/interfaces/imovie.dart';
import 'package:basics_of_dart/network/response.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';

class MovieRepository implements IMovieRepository {
  final Dio dio = Dio();

  @override
  Future<ApiResponse<List<Movie>>> fetchMovies({required String type}) async {
    String baseUrl = IMovieRepository.baseUrl;

    try {
      final response = await dio.get('$baseUrl$type');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> moviesJson = response.data;
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

  Future<ApiResponse<List<Movie>>> searchMovies(
      {required String type, required String query}) async {
    String baseUrl = IMovieRepository.baseUrl;

    try {
      final response = await dio.get('$baseUrl$type');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> moviesJson = response.data;
        List<Movie> listItems =
            moviesJson.map((json) => Movie.fromJson(json)).toList();

        List<Movie> movies = [];
        for (var item in listItems) {
          if (item.title.contains(query)) {
            movies.add(item);
          }
        }
        if (movies.isNotEmpty) {
          return ApiResponse.responseBuilder(
              'Successful', movies, HttpStatus.ok);
        }
        return ApiResponse.responseBuilder(
            'There are no match results', movies, HttpStatus.noContent);
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
