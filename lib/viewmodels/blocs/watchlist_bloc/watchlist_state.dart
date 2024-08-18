part of 'watchlist_bloc.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistMoviesLoaded extends WatchlistState {
  final List<Movie> watchlistMovies;
  WatchlistMoviesLoaded(this.watchlistMovies);
}

class WatchlistError extends WatchlistState {
  final String message;
  WatchlistError(this.message);
}
