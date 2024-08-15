import 'package:equatable/equatable.dart';

import '../../../models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLiked extends MovieState {}

class LikeMovieError extends MovieState {
  final String message;

  const LikeMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
