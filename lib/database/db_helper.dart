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

  // ============ USER CRUD METHODS ============

  // CREATE - Insert a new user
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  // READ - Get user by email
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

  // READ - Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // READ - Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  // UPDATE - Update user
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete user
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // ============ COURSE CRUD METHODS ============

  // CREATE - Add a new course
  Future<int> insertCourse(Map<String, dynamic> course) async {
    Database db = await database;
    return await db.insert('courses', course);
  }

  // READ - Get all courses
  Future<List<Map<String, dynamic>>> getAllCourses() async {
    Database db = await database;
    return await db.query('courses', orderBy: 'examDate ASC');
  }

  // READ - Get a single course by ID
  Future<Map<String, dynamic>?> getCourseById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // UPDATE - Update an existing course
  Future<int> updateCourse(int id, Map<String, dynamic> course) async {
    Database db = await database;
    return await db.update(
      'courses',
      course,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete a course
  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  // ============ RESULT CRUD METHODS (Progress Tracking) ============

  // CREATE - Save exam result
  Future<int> insertResult(Map<String, dynamic> result) async {
    Database db = await database;
    return await db.insert('results', result);
  }

  // READ - Get results by user ID
  Future<List<Map<String, dynamic>>> getResultsByUser(int userId) async {
    Database db = await database;
    return await db.query(
      'results',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'completedDate DESC',
    );
  }

  // READ - Get all results
  Future<List<Map<String, dynamic>>> getAllResults() async {
    Database db = await database;
    return await db.query('results', orderBy: 'completedDate DESC');
  }

  // READ - Get result by ID
  Future<Map<String, dynamic>?> getResultById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'results',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // UPDATE - Update result (if needed)
  Future<int> updateResult(int id, Map<String, dynamic> result) async {
    Database db = await database;
    return await db.update(
      'results',
      result,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete a result
  Future<int> deleteResult(int id) async {
    Database db = await database;
    return await db.delete('results', where: 'id = ?', whereArgs: [id]);
  }

  // DELETE - Delete all results for a user
  Future<int> deleteResultsByUser(int userId) async {
    Database db = await database;
    return await db.delete('results', where: 'userId = ?', whereArgs: [userId]);
  }

  // ============ HELPER METHODS ============

  // Get total number of courses
  Future<int> getCourseCount() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT(*) as count FROM courses');
    return result.first['count'] as int;
  }

  // Get total number of exams taken by user
  Future<int> getExamCountByUser(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM results WHERE userId = ?',
      [userId],
    );
    return result.first['count'] as int;
  }

  // Get average score for a user
  Future<double> getAverageScoreByUser(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT AVG(score) as avgScore FROM results WHERE userId = ?',
      [userId],
    );
    return result.first['avgScore'] as double? ?? 0.0;
  }

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    Database db = await database;
    await db.delete('users');
    await db.delete('courses');
    await db.delete('results');
  }
}