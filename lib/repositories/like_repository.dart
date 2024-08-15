import 'dart:io';
import 'package:basics_of_dart/databases/sqlite/likes_database.dart';
import 'package:basics_of_dart/interfaces/ilike.dart';
import 'package:basics_of_dart/models/movie.dart';
import 'package:basics_of_dart/network/response.dart';
import 'package:basics_of_dart/repositories/movie_repository.dart';
import 'package:dio/dio.dart';
import 'package:basics_of_dart/models/like.dart';

class LikeRepository implements ILikeRepository {
  LikeRepository._();

  // Singleton instance
  static final LikeRepository _instance = LikeRepository._();

  static get instance => _instance;

  final Dio dio = Dio();
  final LikesDatabase _databaseHelper = LikesDatabase.instance;
  final MovieRepository _movieRepository = MovieRepository.instance;
  @override
  // ignore: non_constant_identifier_names
  Future<ApiResponse<List<Movie>>> fetchLikes(
      {required String type, required int user_id}) async {
    try {
      // Fetch liked movie IDs for the user
      final movieIds = await _databaseHelper.getLikedMoviesFor(user_id);

      // Fetch all movies based on the provided type
      final response = await _movieRepository.fetchMovies(type: type);

      if (response.status == HttpStatus.ok) {
        // Filter the fetched movies to include only those whose IDs are in the liked movie IDs
        List<Movie> likedMovies = [];
        for (Movie movie in response.data!) {
          // Check if the movie's ID is in the list of liked movie IDs
          if (movieIds.contains(movie.id)) {
            likedMovies.add(movie);
          }
        }

        if (likedMovies.isNotEmpty) {
          return ApiResponse.responseBuilder(
              'Successful', likedMovies, HttpStatus.ok);
        } else {
          return ApiResponse.responseBuilder(
              'No liked movies found', [], HttpStatus.noContent);
        }
      } else {
        return ApiResponse.responseBuilder(
            'Failed to fetch movies', [], HttpStatus.expectationFailed);
      }
    } catch (e) {
      return ApiResponse.responseBuilder(
          'An error occurred while fetching liked movies: $e',
          [],
          HttpStatus.internalServerError);
    }
  }

  @override
  // ignore: non_constant_identifier_names
  Future<ApiResponse> addLike(
      // ignore: non_constant_identifier_names
      {required int user_id,
      required int movie_id}) async {
    try {
      final like = Like(user_id: user_id, movie_id: movie_id);
      await _databaseHelper.addLike(like);
      return ApiResponse.responseBuilder(
          'Movie liked successfully', null, HttpStatus.ok);
    } catch (e) {
      return ApiResponse.responseBuilder(
          'An error occurred while liking the movie: $e',
          null,
          HttpStatus.internalServerError);
    }
  }
}
