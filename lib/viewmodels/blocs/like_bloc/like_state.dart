import 'package:equatable/equatable.dart';

import '../../../models/movie.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeLoaded extends LikeState {
  final List<Movie> movies;

  const LikeLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class LikeError extends LikeState {
  final String message;

  const LikeError(this.message);

  @override
  List<Object> get props => [message];
}
