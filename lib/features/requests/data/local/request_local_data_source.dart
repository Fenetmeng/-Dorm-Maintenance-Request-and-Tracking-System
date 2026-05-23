import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_tables.dart';
import '../../domain/models/maintenance_request_model.dart';

class RequestLocalDataSource {
  final AppDatabase _db = AppDatabase.instance;

  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    final maps = await _db.getAll(DatabaseTables.maintenanceRequests);
    return maps.map((map) => MaintenanceRequestModel.fromMap(map)).toList();
  }

  Future<List<MaintenanceRequestModel>> getRequestsByUser(String userEmail) async {
    final maps = await _db.getWhere(
      DatabaseTables.maintenanceRequests,
      'userEmail = ?',
      [userEmail],
    );
    return maps.map((map) => MaintenanceRequestModel.fromMap(map)).toList();
  }

  Future<MaintenanceRequestModel?> getRequestById(int id) async {
    final maps = await _db.getWhere(
      DatabaseTables.maintenanceRequests,
      'id = ?',
      [id],
    );
    if (maps.isEmpty) return null;
    return MaintenanceRequestModel.fromMap(maps.first);
  }

  Future<int> createRequest(MaintenanceRequestModel request) async {
    return await _db.insert(
      DatabaseTables.maintenanceRequests,
      request.toMap(),
    );
  }

  Future<void> updateRequest(MaintenanceRequestModel request) async {
    await _db.update(
      DatabaseTables.maintenanceRequests,
      request.toMap(),
      'id = ?',
      [request.id],
    );
  }

  Future<void> deleteRequest(int id) async {
    await _db.delete(
      DatabaseTables.maintenanceRequests,
      'id = ?',
      [id],
    );
  }
}