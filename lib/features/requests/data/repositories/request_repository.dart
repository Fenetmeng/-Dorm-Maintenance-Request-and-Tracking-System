import '../../domain/models/maintenance_request_model.dart';
import '../local/request_local_data_source.dart';
import '../remote/request_remote_data_source.dart';

class RequestRepository {
  final RequestLocalDataSource _localDataSource = RequestLocalDataSource();
  final RequestRemoteDataSource _remoteDataSource = RequestRemoteDataSource();

  Future<List<MaintenanceRequestModel>> getUserRequests(String userEmail) async {
    // Cache-first strategy
    try {
      final localRequests = await _localDataSource.getRequestsByUser(userEmail);
      if (localRequests.isNotEmpty) return localRequests;

      final remoteRequests = await _remoteDataSource.getAllRequests();
      // You can save remote data to local cache here if needed
      return remoteRequests;
    } catch (e) {
      return await _localDataSource.getRequestsByUser(userEmail);
    }
  }

  Future<MaintenanceRequestModel> createRequest({
    required String title,
    required String category,
    required String location,
    required String roomNumber,
    required String description,
    required String userEmail,
  }) async {
    final now = DateTime.now().toIso8601String();

    final request = MaintenanceRequestModel(
      title: title,
      category: category,
      location: location,
      roomNumber: roomNumber,
      description: description,
      dateRequested: now,
      userEmail: userEmail,
    );

    final id = await _localDataSource.createRequest(request);
    final createdRequest = request.copyWith(id: id);

    // Background sync
    _remoteDataSource.syncRequest(createdRequest).catchError((_) {});

    return createdRequest;
  }

  Future<void> updateRequest(MaintenanceRequestModel request) async {
    await _localDataSource.updateRequest(request);
    _remoteDataSource.syncRequest(request).catchError((_) {});
  }

  Future<void> deleteRequest(int id) async {
    await _localDataSource.deleteRequest(id);
  }
}