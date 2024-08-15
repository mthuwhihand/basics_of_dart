import 'package:basics_of_dart/models/like.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LikesDatabase {
  // Private constructor
  LikesDatabase._();

  // Singleton instance
  static final LikesDatabase _instance = LikesDatabase._();

  static get instance => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase('liked_movies.db');
    return _database!;
  }

  // Initialize database and create tables
  Future<Database> _initializeDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  // Create tables if they do not exist
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS likes (
      user_id INTEGER NOT NULL,
      movie_id INTEGER NOT NULL,
      PRIMARY KEY (user_id, movie_id)
    )
    ''');
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {}

  // Insert a new like into the database
  Future<int> addLike(Like like) async {
    final db = await database;
    return await db.insert('likes', like.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Retrieve all movie IDs for a specific user
  Future<List<int>> getLikedMoviesFor(int userId) async {
    final db = await database;
    final result = await db.query(
      'likes',
      columns: ['movie_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.map((row) => row['movie_id'] as int).toList();
  }
}
