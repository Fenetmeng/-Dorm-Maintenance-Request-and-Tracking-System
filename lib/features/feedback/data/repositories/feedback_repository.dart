import '../../../../core/models/cache_result.dart';
import '../../domain/models/feedback_model.dart';
import '../local/feedback_local_data_source.dart';
import '../remote/feedback_remote_data_source.dart';

class FeedbackRepository {
  final FeedbackLocalDataSource _localDataSource = FeedbackLocalDataSource();
  final FeedbackRemoteDataSource _remoteDataSource = FeedbackRemoteDataSource();

  Future<CacheResult<List<FeedbackModel>>> getAllFeedback() async {
    final cachedFeedback = await _localDataSource.getAllFeedback();

    // Always trust SQLite first.
    if (cachedFeedback.isNotEmpty) {
      return CacheResult(
        data: cachedFeedback,
        fromCache: true,
      );
    }

    // Remote fallback only if SQLite is empty.
    final remoteFeedback = await _remoteDataSource.fetchFeedbackFromNetwork();

    return CacheResult(
      data: remoteFeedback,
      fromCache: false,
    );
  }

  Future<List<FeedbackModel>> getFeedbackByUser(String userEmail) async {
    return _localDataSource.getFeedbackByUser(userEmail);
  }

  Future<FeedbackModel> createFeedback(FeedbackModel feedback) async {
    final savedFeedback = await _localDataSource.createFeedback(feedback);
    return savedFeedback;
  }

  Future<void> deleteFeedback(int id) async {
    await _localDataSource.deleteFeedback(id);
  }
}