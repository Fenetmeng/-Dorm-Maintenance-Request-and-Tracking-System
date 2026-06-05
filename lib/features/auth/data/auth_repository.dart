import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_tables.dart';
import '../domain/models/user_model.dart';

class AuthRepository {
  final AppDatabase _database = AppDatabase.instance;

  static final List<UserModel> _webUsers = [
    const UserModel(
      id: 1,
      name: 'Admin',
      email: 'admin@dormfix.com',
      password: 'admin123',
      role: 'admin',
    ),
  ];

  Future<void> createDefaultAdminIfNeeded() async {
    if (kIsWeb) {
      final exists = _webUsers.any(
        (user) => user.email == 'admin@dormfix.com',
      );

      if (!exists) {
        _webUsers.add(
          const UserModel(
            id: 1,
            name: 'Admin',
            email: 'admin@dormfix.com',
            password: 'admin123',
            role: 'admin',
          ),
        );
      }

      return;
    }

    final existingAdmin = await _database.getWhere(
      DatabaseTables.users,
      'email = ?',
      ['admin@dormfix.com'],
    );

    if (existingAdmin.isNotEmpty) {
      return;
    }

    final admin = UserModel(
      name: 'Admin',
      email: 'admin@dormfix.com',
      password: 'admin123',
      role: 'admin',
    );

    await _database.insert(
      DatabaseTables.users,
      admin.toMap(),
    );
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    if (kIsWeb) {
      final existingUser = _webUsers.any((user) => user.email == email);

      if (existingUser) {
        throw Exception('User already exists');
      }

      final user = UserModel(
        id: _webUsers.length + 1,
        name: name,
        email: email,
        password: password,
        role: role,
      );

      _webUsers.add(user);

      return user;
    }

    final existingUsers = await _database.getWhere(
      DatabaseTables.users,
      'email = ?',
      [email],
    );

    if (existingUsers.isNotEmpty) {
      throw Exception('User already exists');
    }

    final user = UserModel(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    final id = await _database.insert(
      DatabaseTables.users,
      user.toMap(),
    );

    return user.copyWith(id: id);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    if (kIsWeb) {
      final users = _webUsers.where((user) {
        return user.email == email && user.password == password;
      }).toList();

      if (users.isEmpty) {
        throw Exception('Invalid email or password');
      }

      return users.first;
    }

    final users = await _database.getWhere(
      DatabaseTables.users,
      'email = ? AND password = ?',
      [email, password],
    );

    if (users.isEmpty) {
      throw Exception('Invalid email or password');
    }

    return UserModel.fromMap(users.first);
  }

  Future<void> deleteAccount(String email) async {
    if (kIsWeb) {
      _webUsers.removeWhere((user) => user.email == email);
      return;
    }

    await _database.delete(
      DatabaseTables.users,
      'email = ?',
      [email],
    );
  }

  Future<List<UserModel>> getAllUsers() async {
    if (kIsWeb) {
      return _webUsers;
    }

    final users = await _database.getAll(DatabaseTables.users);
    return users.map((user) => UserModel.fromMap(user)).toList();
  }
}