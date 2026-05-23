import '../../../../core/models/cache_result.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../../domain/models/assignment_model.dart';
import '../../domain/models/staff_model.dart';
import '../local/admin_local_data_source.dart';
import '../remote/admin_remote_data_source.dart';

class AdminRepository {
  final AdminLocalDataSource _localDataSource = AdminLocalDataSource();
  final AdminRemoteDataSource _remoteDataSource = AdminRemoteDataSource();

  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    return _localDataSource.getAllRequests();
  }

  Future<CacheResult<List<StaffModel>>> getStaff() async {
    final cachedStaff = await _localDataSource.getStaff();

    if (cachedStaff.isNotEmpty) {
      return CacheResult(
        data: cachedStaff,
        fromCache: true,
      );
    }

    final remoteStaff = await _remoteDataSource.fetchStaffFromNetwork();

    await _localDataSource.saveStaffList(remoteStaff);

    final savedStaff = await _localDataSource.getStaff();

    return CacheResult(
      data: savedStaff,
      fromCache: false,
    );
  }

  Future<List<AssignmentModel>> getAssignments() async {
    return _localDataSource.getAssignments();
  }

  Future<AssignmentModel> assignStaffToRequest({
    required int requestId,
    required String staffName,
    required String staffRole,
  }) async {
    final assignment = AssignmentModel(
      requestId: requestId,
      staffName: staffName,
      staffRole: staffRole,
      status: 'In Progress',
      assignedDate: DateTime.now().toIso8601String(),
    );

    final savedAssignment = await _localDataSource.saveAssignment(assignment);

    await _localDataSource.updateRequestStatus(
      requestId: requestId,
      status: 'In Progress',
    );

    return savedAssignment;
  }

  Future<void> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    await _localDataSource.updateRequestStatus(
      requestId: requestId,
      status: status,
    );

    final existingAssignment =
        await _localDataSource.getAssignmentByRequestId(requestId);

    if (existingAssignment != null) {
      await _localDataSource.saveAssignment(
        existingAssignment.copyWith(status: status),
      );
    }
  }
}