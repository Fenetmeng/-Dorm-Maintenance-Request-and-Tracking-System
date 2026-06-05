import 'package:flutter/foundation.dart';

import '../../../../core/models/cache_result.dart';
import '../../../requests/data/remote/request_remote_data_source.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../../domain/models/assignment_model.dart';
import '../../domain/models/staff_model.dart';
import '../local/admin_local_data_source.dart';
import '../remote/admin_remote_data_source.dart';

class AdminRepository {
  final AdminLocalDataSource _localDataSource = AdminLocalDataSource();
  final AdminRemoteDataSource _remoteDataSource = AdminRemoteDataSource();
  final RequestRemoteDataSource _requestRemoteDataSource =
      RequestRemoteDataSource();

  static final List<AssignmentModel> _webAssignments = [];

  static const List<StaffModel> _webStaff = [
    StaffModel(
      id: 1,
      name: 'Mike R.',
      role: 'Plumber',
      phone: '+251 911 111 111',
    ),
    StaffModel(
      id: 2,
      name: 'Sarah L.',
      role: 'General',
      phone: '+251 922 222 222',
    ),
    StaffModel(
      id: 3,
      name: 'David W.',
      role: 'Electrician',
      phone: '+251 933 333 333',
    ),
  ];

  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    if (kIsWeb) {
      return _requestRemoteDataSource.getAllRequests();
    }

    try {
      return await _requestRemoteDataSource.getAllRequests();
    } catch (e) {
      return _localDataSource.getAllRequests();
    }
  }

  Future<CacheResult<List<StaffModel>>> getStaff() async {
    if (kIsWeb) {
      return CacheResult(
  data: _webStaff,
  fromCache: false,
);
    }

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
    if (kIsWeb) {
      return _webAssignments;
    }

    return _localDataSource.getAssignments();
  }

  Future<AssignmentModel> assignStaffToRequest({
    required int requestId,
    required String staffName,
    required String staffRole,
  }) async {
    final assignment = AssignmentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      requestId: requestId,
      staffName: staffName,
      staffRole: staffRole,
      status: 'In Progress',
      assignedDate: DateTime.now().toIso8601String(),
    );

    if (kIsWeb) {
      _webAssignments.removeWhere(
        (item) => item.requestId == requestId,
      );

      _webAssignments.add(assignment);

      final requests = await _requestRemoteDataSource.getAllRequests();

      final selectedRequest = requests.firstWhere(
        (request) => request.id == requestId,
      );

      await _requestRemoteDataSource.updateRequest(
        selectedRequest.copyWith(status: 'In Progress'),
      );

      return assignment;
    }

    final savedAssignment = await _localDataSource.saveAssignment(assignment);

    await _localDataSource.updateRequestStatus(
      requestId: requestId,
      status: 'In Progress',
    );

    final requests = await _requestRemoteDataSource.getAllRequests();

    final selectedRequest = requests.firstWhere(
      (request) => request.id == requestId,
    );

    await _requestRemoteDataSource.updateRequest(
      selectedRequest.copyWith(status: 'In Progress'),
    );

    return savedAssignment;
  }

  Future<void> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    if (kIsWeb) {
      final requests = await _requestRemoteDataSource.getAllRequests();

      final selectedRequest = requests.firstWhere(
        (request) => request.id == requestId,
      );

      await _requestRemoteDataSource.updateRequest(
        selectedRequest.copyWith(status: status),
      );

      final index = _webAssignments.indexWhere(
        (assignment) => assignment.requestId == requestId,
      );

      if (index != -1) {
        _webAssignments[index] = _webAssignments[index].copyWith(
          status: status,
        );
      }

      return;
    }

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

    final requests = await _requestRemoteDataSource.getAllRequests();

    final selectedRequest = requests.firstWhere(
      (request) => request.id == requestId,
    );

    await _requestRemoteDataSource.updateRequest(
      selectedRequest.copyWith(status: status),
    );
  }
}