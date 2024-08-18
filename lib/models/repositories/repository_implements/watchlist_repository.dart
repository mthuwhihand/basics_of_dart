import 'package:basics_of_dart/data/local/local_database_interfaces/watchlist_datasource_interface.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/iwatchlist_repository.dart';

class WatchlistRepository implements IWatchlistRepository {
  WatchlistRepository._();

  static final WatchlistRepository _instance = WatchlistRepository._();
  late final IWatchlistLocalDataSource _localDataSource;

  static Future<WatchlistRepository> getInstance(
      IWatchlistLocalDataSource localDataSource) async {
    _instance._localDataSource = localDataSource;
    return _instance;
  }

  @override
  Future<void> addToWatchlist(int movieId) {
    return _localDataSource.addToWatchlist(movieId);
  }

  @override
  Future<void> removeFromWatchlist(int movieId) {
    return _localDataSource.removeFromWatchlist(movieId);
  }

  @override
  Future<List<int?>> getWatchlistMovies() {
    return _localDataSource.getWatchlistMovies();
  }
}
