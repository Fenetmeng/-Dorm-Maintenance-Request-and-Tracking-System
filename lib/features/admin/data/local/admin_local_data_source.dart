import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_tables.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../../domain/models/assignment_model.dart';
import '../../domain/models/staff_model.dart';

class AdminLocalDataSource {
  final AppDatabase _database = AppDatabase.instance;

  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    final data = await _database.getAll(DatabaseTables.maintenanceRequests);

    return data.map((item) {
      return MaintenanceRequestModel.fromMap(item);
    }).toList();
  }

  Future<void> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    await _database.update(
      DatabaseTables.maintenanceRequests,
      {'status': status},
      'id = ?',
      [requestId],
    );
  }

  Future<List<AssignmentModel>> getAssignments() async {
    final data = await _database.getAll(DatabaseTables.assignments);

    return data.map((item) {
      return AssignmentModel.fromMap(item);
    }).toList();
  }

  Future<AssignmentModel?> getAssignmentByRequestId(int requestId) async {
    final data = await _database.getWhere(
      DatabaseTables.assignments,
      'requestId = ?',
      [requestId],
    );

    if (data.isEmpty) return null;

    return AssignmentModel.fromMap(data.first);
  }

  Future<AssignmentModel> saveAssignment(
    AssignmentModel assignment,
  ) async {
    final existingAssignment =
        await getAssignmentByRequestId(assignment.requestId);

    if (existingAssignment != null) {
      final updatedAssignment = assignment.copyWith(
        id: existingAssignment.id,
      );

      await _database.update(
        DatabaseTables.assignments,
        updatedAssignment.toMap(),
        'id = ?',
        [existingAssignment.id],
      );

      return updatedAssignment;
    }

    final id = await _database.insert(
      DatabaseTables.assignments,
      assignment.toMap(),
    );

    return assignment.copyWith(id: id);
  }

  Future<List<StaffModel>> getStaff() async {
    final data = await _database.getAll(DatabaseTables.staff);

    return data.map((item) {
      return StaffModel.fromMap(item);
    }).toList();
  }

  Future<void> saveStaffList(List<StaffModel> staffList) async {
    for (final staff in staffList) {
      await _database.insert(
        DatabaseTables.staff,
        staff.toMap(),
      );
    }
  }
}