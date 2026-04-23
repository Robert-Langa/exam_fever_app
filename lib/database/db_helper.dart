import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'exam_fever.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');

    // Courses table
    await db.execute('''
      CREATE TABLE courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        education TEXT NOT NULL,
        format TEXT NOT NULL,
        level TEXT NOT NULL,
        examDate TEXT NOT NULL,
        address TEXT NOT NULL,
        includeAnswers INTEGER DEFAULT 0
      )
    ''');

    // Results table for progress tracking
    await db.execute('''
      CREATE TABLE results(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        courseName TEXT NOT NULL,
        score INTEGER NOT NULL,
        totalQuestions INTEGER NOT NULL,
        completedDate TEXT NOT NULL
      )
    ''');
  }

  // ============ USER METHODS ============

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // ============ COURSE METHODS ============

  Future<int> insertCourse(Map<String, dynamic> course) async {
    Database db = await database;
    return await db.insert('courses', course);
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    Database db = await database;
    return await db.query('courses', orderBy: 'examDate ASC');
  }

  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  // ============ RESULT METHODS (PROGRESS TRACKING) ============

  Future<int> insertResult(Map<String, dynamic> result) async {
    Database db = await database;
    return await db.insert('results', result);
  }

  Future<List<Map<String, dynamic>>> getResultsByUser(int userId) async {
    Database db = await database;
    return await db.query(
      'results',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'completedDate DESC',
    );
  }
}