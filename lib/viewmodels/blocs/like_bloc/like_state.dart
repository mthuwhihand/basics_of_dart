part of 'like_bloc.dart';

abstract class LikeState {}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikedMoviesLoaded extends LikeState {
  final List<Movie> likedMovies;
  LikedMoviesLoaded(this.likedMovies);
}

class LikeError extends LikeState {
  final String message;
  LikeError(this.message);
}
