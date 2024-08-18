interface class ILikeRepository {
  Future<void> addLike(int movieId) async {
    throw UnimplementedError();
  }

  Future<void> removeLike(int movieId) async {
    throw UnimplementedError();
  }

  Future<List<int>> getLikedMovies() async {
    throw UnimplementedError();
  }
}
