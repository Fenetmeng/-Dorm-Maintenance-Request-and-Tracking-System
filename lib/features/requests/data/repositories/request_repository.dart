import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../domain/models/maintenance_request_model.dart';
import '../local/request_local_data_source.dart';
import '../remote/request_remote_data_source.dart';

class RequestRepository {
  final RequestLocalDataSource _localDataSource = RequestLocalDataSource();
  final RequestRemoteDataSource _remoteDataSource = RequestRemoteDataSource();

  Future<List<MaintenanceRequestModel>> getUserRequests(String userEmail) async {
    try {
      final remoteRequests = await _remoteDataSource.getAllRequests();

      return remoteRequests.where((request) {
        return request.userEmail == userEmail;
      }).toList();
    } catch (e) {
      if (kIsWeb) {
        throw Exception('Backend API is not running');
      }

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
    String? imagePath,
    PlatformFile? imageFile,
  }) async {
    final now = DateTime.now().toIso8601String();

    String? uploadedImageUrl = imagePath;

    if (imageFile != null) {
      uploadedImageUrl = await _remoteDataSource.uploadImage(imageFile);
    }

    final request = MaintenanceRequestModel(
      title: title,
      category: category,
      location: location,
      roomNumber: roomNumber,
      description: description,
      dateRequested: now,
      userEmail: userEmail,
      imagePath: uploadedImageUrl,
    );

    final createdRequest = await _remoteDataSource.createRequest(request);

    if (!kIsWeb) {
      await _localDataSource.createRequest(createdRequest);
    }

    return createdRequest;
  }

  Future<void> updateRequest(MaintenanceRequestModel request) async {
    final updatedRequest = await _remoteDataSource.updateRequest(request);

    if (!kIsWeb) {
      await _localDataSource.updateRequest(updatedRequest);
    }
  }

  Future<void> deleteRequest(int id) async {
    await _remoteDataSource.deleteRequest(id);

    if (!kIsWeb) {
      await _localDataSource.deleteRequest(id);
    }
  }
}