import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../requests/domain/models/maintenance_request_model.dart';
import '../../data/repositories/admin_repository.dart';
import '../../domain/models/assignment_model.dart';
import '../../domain/models/staff_model.dart';

class AdminState {
  final List<MaintenanceRequestModel> requests;
  final List<AssignmentModel> assignments;
  final List<StaffModel> staff;
  final bool isLoading;
  final String? errorMessage;
  final bool staffFromCache;

  const AdminState({
    this.requests = const [],
    this.assignments = const [],
    this.staff = const [],
    this.isLoading = false,
    this.errorMessage,
    this.staffFromCache = false,
  });

  int get totalRequests => requests.length;

  int get pendingRequests {
    return requests.where((request) {
      return request.status.toLowerCase() == 'pending';
    }).length;
  }

  int get inProgressRequests {
    return requests.where((request) {
      return request.status.toLowerCase().contains('progress');
    }).length;
  }

  int get completedRequests {
    return requests.where((request) {
      return request.status.toLowerCase() == 'completed';
    }).length;
  }

  AdminState copyWith({
    List<MaintenanceRequestModel>? requests,
    List<AssignmentModel>? assignments,
    List<StaffModel>? staff,
    bool? isLoading,
    String? errorMessage,
    bool? staffFromCache,
    bool clearError = false,
  }) {
    return AdminState(
      requests: requests ?? this.requests,
      assignments: assignments ?? this.assignments,
      staff: staff ?? this.staff,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      staffFromCache: staffFromCache ?? this.staffFromCache,
    );
  }
}

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository();
});

final adminProvider = NotifierProvider<AdminNotifier, AdminState>(
  AdminNotifier.new,
);

class AdminNotifier extends Notifier<AdminState> {
  late final AdminRepository _repository;

  @override
  AdminState build() {
    _repository = ref.read(adminRepositoryProvider);
    return const AdminState();
  }

  Future<void> loadAdminData() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final requests = await _repository.getAllRequests();
      final assignments = await _repository.getAssignments();
      final staffResult = await _repository.getStaff();

      state = AdminState(
        requests: requests,
        assignments: assignments,
        staff: staffResult.data,
        isLoading: false,
        staffFromCache: staffResult.fromCache,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> assignStaffToRequest({
    required int requestId,
    required String staffName,
    required String staffRole,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.assignStaffToRequest(
        requestId: requestId,
        staffName: staffName,
        staffRole: staffRole,
      );

      await loadAdminData();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.updateRequestStatus(
        requestId: requestId,
        status: status,
      );

      await loadAdminData();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  int workloadForStaff(String staffName) {
    return state.assignments.where((assignment) {
      return assignment.staffName == staffName &&
          assignment.status.toLowerCase().contains('progress');
    }).length;
  }

  int completedForStaff(String staffName) {
    return state.assignments.where((assignment) {
      return assignment.staffName == staffName &&
          assignment.status.toLowerCase() == 'completed';
    }).length;
  }
}