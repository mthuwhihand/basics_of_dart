import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent(this.type, this.user_id);

  final String type;
  // ignore: non_constant_identifier_names
  final int user_id;

  @override
  List<Object> get props => [type];
}

class FetchLikedMovies extends LikeEvent {
  const FetchLikedMovies(super.type, super.user_id);
}

class RefreshLikedMovies extends LikeEvent {
  const RefreshLikedMovies(super.type, super.user_id);
}

class LoadMoreLikedMovies extends LikeEvent {
  const LoadMoreLikedMovies(super.type, super.user_id);
}
