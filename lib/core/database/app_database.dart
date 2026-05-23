import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_tables.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'dormfix.db');

    return openDatabase(
      path,
      version: 4,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseTables.users} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.maintenanceRequests} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        location TEXT NOT NULL,
        roomNumber TEXT NOT NULL,
        description TEXT NOT NULL,
        status TEXT NOT NULL,
        dateRequested TEXT NOT NULL,
        userEmail TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.assignments} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        requestId INTEGER NOT NULL,
        staffName TEXT NOT NULL,
        staffRole TEXT NOT NULL,
        status TEXT NOT NULL,
        assignedDate TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.staff} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseTables.feedback} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        requestId INTEGER NOT NULL,
        requestTitle TEXT NOT NULL,
        userName TEXT NOT NULL,
        userEmail TEXT NOT NULL,
        rating INTEGER NOT NULL,
        comment TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> _upgradeTables(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${DatabaseTables.staff} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          role TEXT NOT NULL,
          phone TEXT NOT NULL
        )
      ''');
    }

    if (oldVersion < 3) {
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.feedback}');

      await db.execute('''
        CREATE TABLE ${DatabaseTables.feedback} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          requestId INTEGER NOT NULL,
          requestTitle TEXT NOT NULL,
          userName TEXT NOT NULL,
          userEmail TEXT NOT NULL,
          rating INTEGER NOT NULL,
          comment TEXT NOT NULL,
          createdAt TEXT NOT NULL
        )
      ''');
    }
    if (oldVersion < 4) {
  await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.feedback}');

  await db.execute('''
    CREATE TABLE ${DatabaseTables.feedback} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      requestId INTEGER NOT NULL,
      requestTitle TEXT NOT NULL,
      userName TEXT NOT NULL,
      userEmail TEXT NOT NULL,
      rating INTEGER NOT NULL,
      comment TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''');
}
  }
   

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;

    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;

    return db.query(table);
  }

  Future<List<Map<String, dynamic>>> getWhere(
    String table,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;

    return db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;

    return db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;

    return db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}