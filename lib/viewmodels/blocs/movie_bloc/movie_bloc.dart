import 'dart:io';
import 'package:basics_of_dart/interfaces/imovie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IMovieRepository movieRepository;
  int _currentPage = 1; // Tracks the current page number for pagination
  final int _pageSize = 10; // Number of movies per page
  bool _hasMoreMovies = true; // Flag to check if there are more movies to load

  final _searchQuery = BehaviorSubject<Map<String, String>>();

  // Getter
  bool get hasMoreMovies => _hasMoreMovies;
  Stream<Map<String, String>> get searchQuery => _searchQuery.stream;
  // Initialize HomeBloc with MovieRepository and set up event handlers
  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<RefreshMovies>(_onRefreshMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<SearchMovies>(_onSearchMovies);

    // Listen to search query changes and fetch movies based on the search term
    _searchQuery.debounceTime(const Duration(seconds: 1)).listen((params) {
      final type = params['type']!;
      final query = params['query']!;
      add(SearchMovies(type, query));
    });
  }

  // Dispose the search query stream
  @override
  Future<void> close() {
    _searchQuery.close();
    return super.close();
  }

  // Handle searching movies event
  void setSearchQuery({required String type, required String query}) {
    _searchQuery.add({'type': type, 'query': query});
  }

  // Handle searching movies event
  Future<void> _onSearchMovies(
      SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final response = await movieRepository.searchMovies(
          type: event.type, query: event.query);
      if (response.status == HttpStatus.ok) {
        emit(MovieLoaded(response.data!));
      }
      // else if (response.status == HttpStatus.noContent) {
      //   emit(MovieError(response.message!));
      // }
      else {
        emit(MovieError(response.message!));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Handle fetching movies event
  Future<void> _onFetchMovies(
      FetchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    // Delay for 50 milliseconds before proceeding
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      // Fetch all movies
      final response = await movieRepository.fetchMovies(type: event.type);
      if (response.status == HttpStatus.ok) {
        _hasMoreMovies = response.data!.length >
            _pageSize; // Check if there are more movies to load

        emit(MovieLoaded(
            response.data!.take(_pageSize).toList())); // Emit refreshed movies
      } else if (response.status == HttpStatus.expectationFailed) {
        emit(MovieLoaded(
            response.data!.take(_pageSize).toList())); // Emit refreshed movies
      } else {
        emit(MovieError(response.message!));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Handle refreshing movies event
  Future<void> _onRefreshMovies(
      RefreshMovies event, Emitter<MovieState> emit) async {
    _currentPage = 1;
    _hasMoreMovies = true;
    // _onFetchMovies(HomeFetchMovies(event.type), emit);

    emit(MovieLoading());
    // Delay for 50 milliseconds before proceeding
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      // Fetch all movies
      final response = await movieRepository.fetchMovies(type: event.type);
      if (response.status == HttpStatus.ok) {
        _hasMoreMovies = response.data!.length >
            _pageSize; // Check if there are more movies to load

        emit(MovieLoaded(
            response.data!.take(_pageSize).toList())); // Emit refreshed movies
      } else if (response.status == HttpStatus.expectationFailed) {
        emit(MovieLoaded(
            response.data!.take(_pageSize).toList())); // Emit refreshed movies
      } else {
        emit(MovieError(response.message!));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  // Handle loading more movies event
  Future<void> _onLoadMoreMovies(
      LoadMoreMovies event, Emitter<MovieState> emit) async {
    if (state is MovieLoaded && _hasMoreMovies) {
      final currentState = state as MovieLoaded;
      _currentPage++;
      try {
        // Fetch all movies
        final response = await movieRepository.fetchMovies(type: event.type);
        if (response.status == HttpStatus.ok) {
          final fetchedMovies = response.data!
              .skip((_currentPage - 1) * _pageSize)
              .take(_pageSize)
              .toList();

          // Check if the fetched movies are fewer than the page size, indicating no more movies to load
          if (fetchedMovies.length < _pageSize) {
            _hasMoreMovies = false;
          }
          emit(MovieLoaded(List.from(currentState.movies)
            ..addAll(fetchedMovies))); // Emit the updated list of movies
        } else {
          emit(MovieError(response.message!));
        }
      } catch (e) {
        emit(MovieError(
            e.toString())); // Emit error state if an exception occurs
      }
    }
  }
}
