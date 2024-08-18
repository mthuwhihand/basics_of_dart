import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/entities/entities_library.dart';
import 'package:basics_of_dart/models/services/services_library.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistService _watchlistService;

  WatchlistBloc(this._watchlistService) : super(WatchlistInitial()) {
    on<FetchWatchlistMoviesEvent>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
      FetchWatchlistMoviesEvent event, Emitter<WatchlistState> emit) async {
    emit(WatchlistLoading());
    try {
      final result = await _watchlistService.getWatchlistMovies();
      if (result is Success<List<Movie>>) {
        emit(WatchlistMoviesLoaded(result.data));
      } else if (result is Failure<List<Movie>>) {
        emit(WatchlistError(result.message));
      }
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }
}
