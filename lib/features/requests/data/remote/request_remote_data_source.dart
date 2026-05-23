import '../../domain/models/maintenance_request_model.dart';

// Mock remote data source (you can connect to real API later)
class RequestRemoteDataSource {
  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return []; // Return empty for now (cache-first strategy)
  }

  Future<void> syncRequest(MaintenanceRequestModel request) async {
    // TODO: Send to real backend later
    await Future.delayed(const Duration(milliseconds: 500));
  }
}