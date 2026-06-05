import 'package:flutter/foundation.dart';

import '../../../../core/models/cache_result.dart';
import '../../domain/models/feedback_model.dart';
import '../local/feedback_local_data_source.dart';
import '../remote/feedback_remote_data_source.dart';

class FeedbackRepository {
  final FeedbackLocalDataSource _localDataSource = FeedbackLocalDataSource();
  final FeedbackRemoteDataSource _remoteDataSource = FeedbackRemoteDataSource();

  Future<CacheResult<List<FeedbackModel>>> getAllFeedback() async {
    try {
      final remoteFeedback = await _remoteDataSource.getAllFeedback();

      return CacheResult(
        data: remoteFeedback,
        fromCache: false,
      );
    } catch (e) {
      if (kIsWeb) {
        throw Exception('Backend API is not running');
      }

      final cachedFeedback = await _localDataSource.getAllFeedback();

      return CacheResult(
        data: cachedFeedback,
        fromCache: true,
      );
    }
  }

  Future<List<FeedbackModel>> getFeedbackByUser(String userEmail) async {
    try {
      final result = await _remoteDataSource.getAllFeedback();

      return result.where((feedback) {
        return feedback.userEmail == userEmail;
      }).toList();
    } catch (e) {
      if (kIsWeb) {
        throw Exception('Backend API is not running');
      }

      return _localDataSource.getFeedbackByUser(userEmail);
    }
  }

  Future<FeedbackModel> createFeedback(FeedbackModel feedback) async {
    final createdFeedback = await _remoteDataSource.createFeedback(feedback);

    if (!kIsWeb) {
      await _localDataSource.createFeedback(createdFeedback);
    }

    return createdFeedback;
  }

  Future<void> deleteFeedback(int id) async {
    if (!kIsWeb) {
      await _localDataSource.deleteFeedback(id);
    }
  }
}