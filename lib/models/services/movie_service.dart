import 'package:basics_of_dart/models/repositories/repository_interfaces/ilike_repository.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/imovie_repository.dart';
import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/movie.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/iwatchlist_repository.dart';

class MovieService {
  MovieService._();

  static final MovieService _instance = MovieService._();
  late final IMovieRepository _movieRepository;
  late final ILikeRepository _likeRepository;
  late final IWatchlistRepository _watchlistRepository;

  static MovieService getInstance(
    IMovieRepository movieRepository,
    ILikeRepository likeRepository,
    IWatchlistRepository watchlistRepository,
  ) {
    _instance._movieRepository = movieRepository;
    _instance._likeRepository = likeRepository;
    _instance._watchlistRepository = watchlistRepository;
    return _instance;
  }

  Future<ResponseResult<List<Movie>>> fetchAllMovies() async {
    try {
      final movies = await _movieRepository.fetchAll();

      if (movies.isNotEmpty) {
        final likes = await _likeRepository.getLikedMovies();
        final watchlist = await _watchlistRepository.getWatchlistMovies();
        for (var movie in movies) {
          if (likes.contains(movie.id)) {
            movie.isLiked = true;
          }
          if (watchlist.contains(movie.id)) {
            movie.isInWatchlist = true;
          }
        }
        return Success(movies);
      } else {
        return Failure('No movies found.');
      }
    } catch (e) {
      return Failure('An error occurred while fetching movies: $e');
    }
  }

  Future<ResponseResult<List<Movie>>> searchMovies(String query) async {
    try {
      final movies = await _movieRepository.fetchAll();

      if (movies.isNotEmpty) {
        List<Movie> searchResults = [];
        for (var item in movies) {
          if (item.title.toLowerCase().contains(query.toLowerCase())) {
            searchResults.add(item);
          }
        }
        if (searchResults.isNotEmpty) {
          final likedMovieIds = await _likeRepository.getLikedMovies();

          for (var movie in searchResults) {
            if (likedMovieIds.contains(movie.id)) {
              movie.isLiked = true;
            }
          }

          return Success(searchResults);
        }
        return Failure('No movies found for the query: $query');
      } else {
        return Failure('No movies found for the query: $query');
      }
    } catch (e) {
      return Failure('An error occurred while searching movies: $e');
    }
  }
}
