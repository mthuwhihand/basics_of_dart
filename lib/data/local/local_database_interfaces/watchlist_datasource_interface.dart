interface class IWatchlistLocalDataSource {
  Future<void> addToWatchlist(int movieId) async {
    throw UnimplementedError();
  }

  Future<void> removeFromWatchlist(int movieId) async {
    throw UnimplementedError();
  }

  Future<List<int?>> getWatchlistMovies() async {
    throw UnimplementedError();
  }
}
