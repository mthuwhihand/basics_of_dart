import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/ilike_repository.dart';
import 'package:basics_of_dart/models/services/services_library.dart';

class LikeService {
  LikeService._();

  static final LikeService _instance = LikeService._();
  late final ILikeRepository _likeRepository;
  late final MovieService _movieService;

  static LikeService getInstance(
      ILikeRepository likeRepository, MovieService movieService) {
    _instance._likeRepository = likeRepository;
    _instance._movieService = movieService;
    return _instance;
  }

  static get instance => _instance;

  Future<ResponseResult<void>> addLike(int movieId) async {
    try {
      await _likeRepository.addLike(movieId);
      return Success(null);
    } catch (e) {
      return Failure('Failed to add like');
    }
  }

  Future<ResponseResult<void>> removeLike(int movieId) async {
    try {
      await _likeRepository.removeLike(movieId);
      return Success(null);
    } catch (e) {
      return Failure('Failed to remove like');
    }
  }

  Future<ResponseResult<List<Movie>>> fetchAllLikedMovies() async {
    try {
      final result = await _movieService.fetchAllMovies();

      if (result is Success<List<Movie>>) {
        final movies = result.data;
        if (movies.isNotEmpty) {
          List<Movie> likedMovies = [];
          for (var movie in movies) {
            if (movie.isLiked) {
              likedMovies.add(movie);
            }
          }
          return Success(likedMovies);
        } else {
          return Failure('No liked movies found.');
        }
      } else if (result is Failure<List<Movie>>) {
        return Failure(result.message);
      }
    } catch (e) {
      return Failure('An error occurred while fetching movies: $e');
    }
    return Failure('Something went wrong!');
  }
}
