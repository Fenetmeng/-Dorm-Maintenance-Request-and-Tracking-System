import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/repositories/request_repository.dart';
import '../../domain/models/maintenance_request_model.dart';

class RequestState {
  final List<MaintenanceRequestModel> requests;
  final bool isLoading;
  final String? errorMessage;

  const RequestState({
    this.requests = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  RequestState copyWith({
    List<MaintenanceRequestModel>? requests,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RequestState(
      requests: requests ?? this.requests,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  return RequestRepository();
});

final requestProvider = NotifierProvider<RequestNotifier, RequestState>(
  RequestNotifier.new,
);

class RequestNotifier extends Notifier<RequestState> {
  late final RequestRepository _repository;

  @override
  RequestState build() {
    _repository = ref.read(requestRepositoryProvider);
    return const RequestState();
  }

  Future<void> loadUserRequests() async {
    final user = ref.read(authProvider).currentUser;

    if (user == null) {
      state = const RequestState();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final requests = await _repository.getUserRequests(user.email);

      state = RequestState(
        requests: requests,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> createRequest({
    required String title,
    required String category,
    required String location,
    required String roomNumber,
    required String description,
  }) async {
    final user = ref.read(authProvider).currentUser;

    if (user == null) {
      state = state.copyWith(
        errorMessage: 'You must login first',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.createRequest(
        title: title,
        category: category,
        location: location,
        roomNumber: roomNumber,
        description: description,
        userEmail: user.email,
      );

      await loadUserRequests();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> updateRequest(MaintenanceRequestModel request) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.updateRequest(request);
      await loadUserRequests();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> deleteRequest(int id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.deleteRequest(id);
      await loadUserRequests();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void clearRequests() {
    state = const RequestState();
  }
}