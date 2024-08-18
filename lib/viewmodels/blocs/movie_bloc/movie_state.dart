part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLiked extends MovieState {
  final int movieId;

  const MovieLiked(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class LikeMovieError extends MovieState {
  final String message;

  const LikeMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesLoaded extends MovieState {
  final List<Movie> movies;
  const MoviesLoaded(this.movies);
}

class MoviesError extends MovieState {
  final String message;
  const MoviesError(this.message);
}
