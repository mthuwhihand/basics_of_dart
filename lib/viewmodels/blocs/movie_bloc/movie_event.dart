import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

class FetchMovies extends MovieEvent {
  const FetchMovies(super.type);
}

class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies(super.type, this.query);

  @override
  List<Object> get props => [type, query];
}

class LikeMovie extends MovieEvent {
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final int movie_id;

  const LikeMovie(super.type, this.user_id, this.movie_id);

  @override
  List<Object> get props => [type, user_id, movie_id];
}

class RefreshMovies extends MovieEvent {
  const RefreshMovies(super.type);
}

class LoadMoreMovies extends MovieEvent {
  const LoadMoreMovies(super.type);
}
