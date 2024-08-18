import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/iwatchlist_repository.dart';
import 'package:basics_of_dart/models/services/services_library.dart';

class WatchlistService {
  WatchlistService._();

  static final WatchlistService _instance = WatchlistService._();
  late final IWatchlistRepository _watchlistRepository;
  late final MovieService _movieService;

  static WatchlistService getInstance(
      IWatchlistRepository authRepository, MovieService movieService) {
    _instance._watchlistRepository = authRepository;
    _instance._movieService = movieService;
    return _instance;
  }

  Future<ResponseResult<void>> addToWatchlist(int movieId) async {
    try {
      await _watchlistRepository.addToWatchlist(movieId);
      return Success(null);
    } catch (e) {
      return Failure('Failed to add to watchlist: $e');
    }
  }

  Future<ResponseResult<void>> removeFromWatchlist(int movieId) async {
    try {
      await _watchlistRepository.removeFromWatchlist(movieId);
      return Success(null);
    } catch (e) {
      return Failure('Failed to remove from watchlist: $e');
    }
  }

  Future<ResponseResult<List<Movie>>> getWatchlistMovies() async {
    try {
      final result = await _movieService.fetchAllMovies();

      if (result is Success<List<Movie>>) {
        final movies = result.data;
        if (movies.isNotEmpty) {
          List<Movie> watchlistMovies = [];
          for (var movie in movies) {
            if (movie.isInWatchlist) {
              watchlistMovies.add(movie);
            }
          }
          return Success(watchlistMovies);
        } else {
          return Failure('No watchlist movies found.');
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
