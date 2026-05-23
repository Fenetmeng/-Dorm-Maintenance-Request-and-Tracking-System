import '../../domain/models/feedback_model.dart';

class FeedbackRemoteDataSource {
  Future<List<FeedbackModel>> fetchFeedbackFromNetwork() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [];
  }
}