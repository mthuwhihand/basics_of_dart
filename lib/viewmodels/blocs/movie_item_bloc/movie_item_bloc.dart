import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_item_event.dart';
part 'movie_item_state.dart';

class MovieItemBloc extends Bloc<MovieItemEvent, MovieItemState> {
  final int movieId;
  final LikeService _likeService;
  final WatchlistService _watchlistService;

  MovieItemBloc(this.movieId, this._likeService, this._watchlistService)
      : super(MovieItemInitial()) {
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleWatchlistEvent>(_onToggleWatchlist);
  }

  Future<void> _onToggleLike(
      ToggleLikeEvent event, Emitter<MovieItemState> emit) async {
    emit(MovieItemLoading());
    try {
      ResponseResult<void> result;
      if (event.isCurrentlyLiked) {
        result = await _likeService.removeLike(movieId);
      } else {
        result = await _likeService.addLike(movieId);
      }

      if (result is Success) {
        emit(MovieItemLikeToggled(!event.isCurrentlyLiked));
      } else if (result is Failure) {
        emit(MovieItemError(result.message));
      }
    } catch (e) {
      emit(MovieItemError('Failed to toggle like'));
    }
  }

  Future<void> _onToggleWatchlist(
      ToggleWatchlistEvent event, Emitter<MovieItemState> emit) async {
    emit(MovieItemLoading());
    try {
      ResponseResult<void> result;
      if (event.isCurrentlyInWatchlist) {
        result = await _watchlistService.removeFromWatchlist(movieId);
      } else {
        result = await _watchlistService.addToWatchlist(movieId);
      }

      if (result is Success) {
        emit(MovieItemWatchlistToggled(!event.isCurrentlyInWatchlist));
      } else if (result is Failure) {
        emit(MovieItemError(result.message));
      }
    } catch (e) {
      emit(MovieItemError('Failed to toggle watchlist'));
    }
  }
}
