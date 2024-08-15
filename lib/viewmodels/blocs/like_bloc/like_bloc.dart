import 'dart:io';
import 'package:basics_of_dart/interfaces/ilike.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'like_event.dart';
import 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final ILikeRepository likeRepository;
  int _currentPage = 1; // Tracks the current page number for pagination
  final int _pageSize = 10; // Number of movies per page
  bool _hasMoreMovies = true; // Flag to check if there are more movies to load

  // Getter
  bool get hasMoreMovies => _hasMoreMovies;

  // Initialize LikeBloc with MovieRepository and set up event handlers
  LikeBloc({required this.likeRepository}) : super(LikeInitial()) {
    on<FetchLikedMovies>(_onFetchLikedMovies);
    on<RefreshLikedMovies>(_onRefreshLikedMovies);
    on<LoadMoreLikedMovies>(_onLoadMoreLikedMovies);
  }

  // Handle fetching liked movies event
  Future<void> _onFetchLikedMovies(
      FetchLikedMovies event, Emitter<LikeState> emit) async {
    emit(LikeLoading());
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final response = await likeRepository.fetchLikes(
          type: event.type, user_id: event.user_id);
      if (response.status == HttpStatus.ok) {
        _hasMoreMovies = response.data!.length > _pageSize;

        emit(LikeLoaded(response.data!.take(_pageSize).toList()));
      } else if (response.status == HttpStatus.expectationFailed) {
        emit(LikeLoaded(response.data!.take(_pageSize).toList()));
      } else {
        emit(LikeError(response.message!));
      }
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  // Handle refreshing liked movies event
  Future<void> _onRefreshLikedMovies(
      RefreshLikedMovies event, Emitter<LikeState> emit) async {
    _currentPage = 1;
    _hasMoreMovies = true;
    emit(LikeLoading());
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final response = await likeRepository.fetchLikes(
          type: event.type, user_id: event.user_id);
      if (response.status == HttpStatus.ok) {
        _hasMoreMovies = response.data!.length > _pageSize;

        emit(LikeLoaded(response.data!.take(_pageSize).toList()));
      } else if (response.status == HttpStatus.expectationFailed) {
        emit(LikeLoaded(response.data!.take(_pageSize).toList()));
      } else {
        emit(LikeError(response.message!));
      }
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }

  // Handle loading more liked movies event
  Future<void> _onLoadMoreLikedMovies(
      LoadMoreLikedMovies event, Emitter<LikeState> emit) async {
    if (state is LikeLoaded && _hasMoreMovies) {
      final currentState = state as LikeLoaded;
      _currentPage++;
      try {
        final response = await likeRepository.fetchLikes(
            type: event.type, user_id: event.user_id);
        if (response.status == HttpStatus.ok) {
          final fetchedMovies = response.data!
              .skip((_currentPage - 1) * _pageSize)
              .take(_pageSize)
              .toList();

          if (fetchedMovies.length < _pageSize) {
            _hasMoreMovies = false;
          }
          emit(LikeLoaded(
              List.from(currentState.movies)..addAll(fetchedMovies)));
        } else {
          emit(LikeError(response.message!));
        }
      } catch (e) {
        emit(LikeError(e.toString()));
      }
    }
  }
}
