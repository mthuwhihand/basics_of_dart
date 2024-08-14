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

class RefreshMovies extends MovieEvent {
  const RefreshMovies(super.type);
}

class LoadMoreMovies extends MovieEvent {
  const LoadMoreMovies(super.type);
}
