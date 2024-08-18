part of 'movie_item_bloc.dart';

abstract class MovieItemEvent {}

class ToggleLikeEvent extends MovieItemEvent {
  final bool isCurrentlyLiked;
  ToggleLikeEvent(this.isCurrentlyLiked);
}

class ToggleWatchlistEvent extends MovieItemEvent {
  final bool isCurrentlyInWatchlist;
  ToggleWatchlistEvent(this.isCurrentlyInWatchlist);
}
