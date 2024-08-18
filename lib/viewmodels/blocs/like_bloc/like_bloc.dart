import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeService _likeService;

  LikeBloc(this._likeService) : super(LikeInitial()) {
    on<FetchLikedMoviesEvent>(_onFetchLikedMovies);
  }

  Future<void> _onFetchLikedMovies(
      FetchLikedMoviesEvent event, Emitter<LikeState> emit) async {
    emit(LikeLoading());
    try {
      final result = await _likeService.fetchAllLikedMovies();
      if (result is Success<List<Movie>>) {
        emit(LikedMoviesLoaded(result.data));
      } else if (result is Failure<List<Movie>>) {
        emit(LikeError(result.message));
      }
    } catch (e) {
      emit(LikeError(e.toString()));
    }
  }
}
