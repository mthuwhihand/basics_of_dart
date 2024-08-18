import 'package:basics_of_dart/data/local/local_database_interfaces/likes_datasource_interface.dart';
import 'package:basics_of_dart/models/repositories/repository_interfaces/ilike_repository.dart';

class LikeRepository implements ILikeRepository {
  LikeRepository._();

  static final LikeRepository _instance = LikeRepository._();
  late final ILikesLocalDataSource _localDataSource;

  static Future<LikeRepository> getInstance(
      ILikesLocalDataSource localDataSource) async {
    _instance._localDataSource = localDataSource;
    return _instance;
  }

  @override
  Future<void> addLike(int movieId) async {
    await _localDataSource.addLike(movieId);
  }

  @override
  Future<void> removeLike(int movieId) async {
    await _localDataSource.removeLike(movieId);
  }

  @override
  Future<List<int>> getLikedMovies() async {
    return await _localDataSource.getLikedMovies();
  }
}
