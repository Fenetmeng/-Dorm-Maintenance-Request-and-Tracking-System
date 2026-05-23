import '../../../core/database/app_database.dart';
import '../../../core/database/database_tables.dart';
import '../domain/models/user_model.dart';

class AuthRepository {
  final AppDatabase _database = AppDatabase.instance;

  Future<void> createDefaultAdminIfNeeded() async {
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
    await _database.delete(
      DatabaseTables.users,
      'email = ?',
      [email],
    );
  }

  Future<List<UserModel>> getAllUsers() async {
    final users = await _database.getAll(DatabaseTables.users);
    return users.map((user) => UserModel.fromMap(user)).toList();
  }
}