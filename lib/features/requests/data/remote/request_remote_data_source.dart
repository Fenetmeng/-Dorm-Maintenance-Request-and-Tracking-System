import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/maintenance_request_model.dart';

class RequestRemoteDataSource {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<MaintenanceRequestModel>> getAllRequests() async {
    final response = await http.get(
      Uri.parse('$baseUrl/requests'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) {
        return MaintenanceRequestModel.fromMap(item);
      }).toList();
    }

    throw Exception('Failed to load requests from API');
  }

  Future<MaintenanceRequestModel> createRequest(
    MaintenanceRequestModel request,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/requests'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return MaintenanceRequestModel.fromMap(data);
    }

    throw Exception('Failed to create request');
  }

  Future<MaintenanceRequestModel> updateRequest(
    MaintenanceRequestModel request,
  ) async {
    if (request.id == null) {
      throw Exception('Request ID is missing');
    }

    final response = await http.patch(
      Uri.parse('$baseUrl/requests/${request.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return MaintenanceRequestModel.fromMap(data);
    }

    throw Exception('Failed to update request');
  }

  Future<void> deleteRequest(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/requests/$id'),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete request');
    }
  }

  Future<String?> uploadImage(PlatformFile file) async {
    if (file.bytes == null) {
      return null;
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload'),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        file.bytes!,
        filename: file.name,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['imageUrl'] as String?;
    }

    throw Exception('Image upload failed');
  }

  Future<void> syncRequest(MaintenanceRequestModel request) async {
    if (request.id == null) {
      await createRequest(request);
    } else {
      await updateRequest(request);
    }
  }
}