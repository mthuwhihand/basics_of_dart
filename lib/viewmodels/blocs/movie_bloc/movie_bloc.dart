import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;
  final LikeService _likeService;
  final WatchlistService _watchlistService;

  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMoreMovies = true;
  bool get hasMoreMovies => _hasMoreMovies;

  final _movieStream = BehaviorSubject<Movie>();
  Stream<Movie> get movieStream => _movieStream.stream;
  MovieBloc(this._movieService, this._likeService, this._watchlistService)
      : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<RefreshMovieEvent>(_onRefreshMovies);
    on<LoadMoreMovieEvent>(_onLoadMoreMovies);
    on<ToggleLikeEvent>(_onLikeMovieEvent);
    on<ToggleWatchlistEvent>(_onAddToWatchlistEvent);
  }

  Future<void> _onLikeMovieEvent(
      ToggleLikeEvent event, Emitter<MovieState> emit) async {
    if (state is MoviesLoaded) {
      final currentState = state as MoviesLoaded;
      final updatedMovies = currentState.movies.map((movie) {
        if (movie.id == event.movieId) {
          movie.isLiked = !movie.isLiked;
          if (movie.isLiked) {
            _likeService.addLike(movie.id);
          } else {
            _likeService.removeLike(movie.id);
          }
          _movieStream.add(movie);
        }
        return movie;
      }).toList();
      emit(MoviesLoaded(updatedMovies));
    }
  }

  Future<void> _onAddToWatchlistEvent(
      ToggleWatchlistEvent event, Emitter<MovieState> emit) async {
    if (state is MoviesLoaded) {
      final currentState = state as MoviesLoaded;
      final updatedMovies = currentState.movies.map((movie) {
        if (movie.id == event.movieId) {
          movie.isInWatchlist = !movie.isInWatchlist;
          if (movie.isInWatchlist) {
            _watchlistService.addToWatchlist(movie.id);
          } else {
            _watchlistService.removeFromWatchlist(movie.id);
          }
          _movieStream.add(movie);
        }
        return movie;
      }).toList();
      emit(MoviesLoaded(updatedMovies));
    }
  }

  Future<void> _onFetchMovies(
      FetchMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    _hasMoreMovies = true;
    final result = await _movieService.fetchAllMovies();
    if (result is Success<List<Movie>>) {
      emit(MoviesLoaded(result.data));
    } else if (result is Failure<List<Movie>>) {
      emit(MoviesError(result.message));
    }
  }

  Future<void> _onRefreshMovies(
      RefreshMovieEvent event, Emitter<MovieState> emit) async {
    _currentPage = 1;
    _hasMoreMovies = true;
    emit(MovieLoading());

    final result = await _movieService.fetchAllMovies();
    if (result is Success<List<Movie>>) {
      emit(MoviesLoaded(result.data));
    } else if (result is Failure<List<Movie>>) {
      emit(MoviesError(result.message));
    }
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreMovieEvent event, Emitter<MovieState> emit) async {
    if (state is MoviesLoaded && _hasMoreMovies) {
      final currentState = state as MoviesLoaded;
      _currentPage++;

      await Future.delayed(const Duration(milliseconds: 50), () {});
      try {
        final response = await _movieService.fetchAllMovies();

        if (response is Success<List<Movie>>) {
          final fetchedMovies = response.data
              .skip((_currentPage - 1) * _pageSize)
              .take(_pageSize)
              .toList();

          if (fetchedMovies.length < _pageSize) {
            _hasMoreMovies = false;
          }
          emit(MoviesLoaded(
              List.from(currentState.movies)..addAll(fetchedMovies)));
        } else if (response is Failure<List<Movie>>) {
          emit(MoviesError(response.message));
        }
      } catch (e) {
        emit(MoviesError(e.toString()));
      }
    }
  }
}
