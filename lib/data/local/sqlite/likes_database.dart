import 'package:basics_of_dart/data/local/local_database_interfaces/likes_datasource_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteLikedLocalDataSource implements ILikesLocalDataSource {
  static const String _dbName = 'liked_database.db';
  static const String _likedTable = 'liked_movies';
  Database? _database;

  SQLiteLikedLocalDataSource._();

  static final SQLiteLikedLocalDataSource _instance =
      SQLiteLikedLocalDataSource._();

  static get instance => _instance;

  Future<Database> _initDb() async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_likedTable("
          "movie_id INTEGER PRIMARY KEY, "
          "like_at TEXT"
          ")",
        );
      },
      version: 1,
    );

    return _database!;
  }

  @override
  Future<void> addLike(int movieId) async {
    final db = await _initDb();
    // Thêm hoặc thay thế bản ghi nếu movieId đã tồn tại
    await db.insert(
      _likedTable,
      {'movie_id': movieId, 'like_at': DateTime.now().toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeLike(int movieId) async {
    final db = await _initDb();
    // Xóa bản ghi với movieId
    await db.delete(
      _likedTable,
      where: "movie_id = ?",
      whereArgs: [movieId],
    );
  }

  @override
  Future<List<int>> getLikedMovies() async {
    final db = await _initDb();
    final List<Map<String, dynamic>> maps = await db.query(_likedTable);
    return List.generate(maps.length, (i) {
      return maps[i]['movie_id'] as int;
    });
  }
}
