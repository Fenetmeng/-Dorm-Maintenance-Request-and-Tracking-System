import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_tables.dart';
import '../../domain/models/feedback_model.dart';

class FeedbackLocalDataSource {
  final AppDatabase _database = AppDatabase.instance;

  Future<List<FeedbackModel>> getAllFeedback() async {
    final data = await _database.getAll(DatabaseTables.feedback);

    return data.map((item) {
      return FeedbackModel.fromMap(item);
    }).toList();
  }

  Future<List<FeedbackModel>> getFeedbackByUser(String userEmail) async {
    final data = await _database.getWhere(
      DatabaseTables.feedback,
      'userEmail = ?',
      [userEmail],
    );

    return data.map((item) {
      return FeedbackModel.fromMap(item);
    }).toList();
  }

  Future<FeedbackModel> createFeedback(FeedbackModel feedback) async {
    final data = feedback.toMap();

    // Remove id before insert so SQLite can auto-generate it.
    data.remove('id');

    final id = await _database.insert(
      DatabaseTables.feedback,
      data,
    );

    final savedFeedback = feedback.copyWith(id: id);

    final allFeedback = await getAllFeedback();

    if (allFeedback.isEmpty) {
      throw Exception('Feedback was not saved to database');
    }

    return savedFeedback;
  }

  Future<void> deleteFeedback(int id) async {
    await _database.delete(
      DatabaseTables.feedback,
      'id = ?',
      [id],
    );
  }
}