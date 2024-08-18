import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/imovie_repository.dart';
import '../../entities/movie.dart';

class MovieRepository implements IMovieRepository {
  MovieRepository._();

  static final MovieRepository _instance = MovieRepository._();

  static MovieRepository get instance => _instance;

  final Dio dio = Dio();

  @override
  Future<List<Movie>> fetchAll() async {
    try {
      final response = await dio.get(IMovieRepository.baseUrl);

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> data = response.data;
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to fetch movies: ${response.statusMessage ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movies: $e');
    }
  }

  // @override
  // Future<List<Movie>> search({required String query}) async {
  //   try {
  //     final response = await dio.get(IMovieRepository.baseUrl);

  //     if (response.statusCode == HttpStatus.ok) {
  //       List<Movie> data =
  //           response.data.map((json) => Movie.fromJson(json)).toList();

  //       List<Movie> searchResults = [];
  //       for (var item in data) {
  //         if (item.title.toLowerCase().contains(query.toLowerCase())) {
  //           searchResults.add(item);
  //         }
  //       }
  //       return searchResults;
  //     } else {
  //       throw Exception(
  //           'Failed to search movies: ${response.statusMessage ?? 'Unknown error'}');
  //     }
  //   } catch (e) {
  //     throw Exception('An error occurred while searching movies: $e');
  //   }
  // }
}
