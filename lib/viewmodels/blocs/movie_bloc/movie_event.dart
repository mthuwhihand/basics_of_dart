part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesEvent extends MovieEvent {}

// class SearchMovies extends MovieEvent {
//   final String query;

//   const SearchMovies(super.type, super.user_id, this.query);

//   @override
//   List<Object> get props => [type, query];
// }

class ToggleLikeEvent extends MovieEvent {
  final int movieId;
  const ToggleLikeEvent(this.movieId);
}

class UnlikeMovieEvent extends MovieEvent {
  final int movieId;
  const UnlikeMovieEvent(this.movieId);
}

class ToggleWatchlistEvent extends MovieEvent {
  final int movieId;
  const ToggleWatchlistEvent(this.movieId);
}

class RemoveFromWatchlistEvent extends MovieEvent {
  final int movieId;
  const RemoveFromWatchlistEvent(this.movieId);
}

class RefreshMovieEvent extends MovieEvent {
  const RefreshMovieEvent();
}

class LoadMoreMovieEvent extends MovieEvent {
  const LoadMoreMovieEvent();
}
