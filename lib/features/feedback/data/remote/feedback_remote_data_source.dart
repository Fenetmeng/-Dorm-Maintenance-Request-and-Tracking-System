import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/feedback_model.dart';

class FeedbackRemoteDataSource {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<FeedbackModel>> getAllFeedback() async {
    final response = await http.get(
      Uri.parse('$baseUrl/feedback'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) {
        return FeedbackModel.fromMap(item);
      }).toList();
    }

    throw Exception('Failed to load feedback from API');
  }

  Future<FeedbackModel> createFeedback(FeedbackModel feedback) async {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(feedback.toMap()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return FeedbackModel.fromMap(data);
    }

    throw Exception('Failed to submit feedback');
  }
}