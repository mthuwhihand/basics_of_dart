part of 'movie_item_bloc.dart';

abstract class MovieItemState {}

class MovieItemInitial extends MovieItemState {}

class MovieItemLoading extends MovieItemState {}

class MovieItemLikeToggled extends MovieItemState {
  final bool isLiked;
  MovieItemLikeToggled(this.isLiked);
}

class MovieItemWatchlistToggled extends MovieItemState {
  final bool isInWatchlist;
  MovieItemWatchlistToggled(this.isInWatchlist);
}

class MovieItemError extends MovieItemState {
  final String message;
  MovieItemError(this.message);
}
