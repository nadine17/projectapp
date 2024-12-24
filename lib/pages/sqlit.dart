import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT UNIQUE,
          password TEXT,
          genres TEXT
        )
      ''');
    });
  }

  // Insert user data
  Future<void> insertData(Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert('users', userData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Check if email already exists
  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty;
  }

  // Get user by email
  Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await database;
    return await db.query('users', where: 'email = ?', whereArgs: [email]);
  }

  // Update genres for the user
  Future<void> updateGenres(String email, String genres) async {
    final db = await database;
    await db.update(
      'users',
      {'genres': genres},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
