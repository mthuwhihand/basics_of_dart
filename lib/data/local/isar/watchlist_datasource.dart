import 'package:basics_of_dart/data/local/local_database_interfaces/watchlist_datasource_interface.dart';
import 'package:basics_of_dart/models/entities/watchlist_movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarWatchlistLocalDataSource implements IWatchlistLocalDataSource {
  final Isar _isar;
  IsarWatchlistLocalDataSource._(this._isar);

  static IsarWatchlistLocalDataSource? _instance;

  static Future<IsarWatchlistLocalDataSource> getInstance() async {
    if (_instance == null) {
      final directory = await getApplicationDocumentsDirectory();
      final isar =
          await Isar.open([WatchlistMovieSchema], directory: directory.path);
      _instance = IsarWatchlistLocalDataSource._(isar);
    }
    return _instance!;
  }

  @override
  Future<void> addToWatchlist(int movieId) async {
    final watchlist = await _isar.watchlistMovies
        .filter()
        .movieIdEqualTo(movieId)
        .findFirst();

    if (watchlist == null) {
      final newMovie = WatchlistMovie()
        ..movieId = movieId
        ..addedAt = DateTime.now().toIso8601String();

      await _isar.writeTxn(() async {
        await _isar.watchlistMovies.put(newMovie);
      });
    }
  }

  @override
  Future<void> removeFromWatchlist(int movieId) async {
    final watchlist = await _isar.watchlistMovies
        .filter()
        .movieIdEqualTo(movieId)
        .findFirst();

    if (watchlist != null) {
      await _isar.writeTxn(() async {
        await _isar.watchlistMovies.delete(movieId);
      });
    }
  }

  @override
  Future<List<int?>> getWatchlistMovies() async {
    final watchlistMovies = await _isar.watchlistMovies.where().findAll();

    return watchlistMovies.map((movie) => movie.movieId).toList();
  }
}
