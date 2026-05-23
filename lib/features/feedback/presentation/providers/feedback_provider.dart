import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../../data/repositories/feedback_repository.dart';
import '../../domain/models/feedback_model.dart';

class FeedbackState {
  final List<FeedbackModel> feedbackList;
  final bool isLoading;
  final String? errorMessage;
  final bool fromCache;

  const FeedbackState({
    this.feedbackList = const [],
    this.isLoading = false,
    this.errorMessage,
    this.fromCache = false,
  });

  FeedbackState copyWith({
    List<FeedbackModel>? feedbackList,
    bool? isLoading,
    String? errorMessage,
    bool? fromCache,
    bool clearError = false,
  }) {
    return FeedbackState(
      feedbackList: feedbackList ?? this.feedbackList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      fromCache: fromCache ?? this.fromCache,
    );
  }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  return FeedbackRepository();
});

final feedbackProvider = NotifierProvider<FeedbackNotifier, FeedbackState>(
  FeedbackNotifier.new,
);

class FeedbackNotifier extends Notifier<FeedbackState> {
  late final FeedbackRepository _repository;

  @override
  FeedbackState build() {
    _repository = ref.read(feedbackRepositoryProvider);
    return const FeedbackState();
  }

  Future<void> loadAllFeedback() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final result = await _repository.getAllFeedback();

      state = FeedbackState(
        feedbackList: result.data,
        isLoading: false,
        fromCache: result.fromCache,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> loadMyFeedback() async {
    final user = ref.read(authProvider).currentUser;

    if (user == null) {
      state = const FeedbackState();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final feedback = await _repository.getFeedbackByUser(user.email);

      state = FeedbackState(
        feedbackList: feedback,
        isLoading: false,
        fromCache: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> createFeedback({
    required MaintenanceRequestModel request,
    required int rating,
    required String comment,
  }) async {
    final user = ref.read(authProvider).currentUser;

    if (user == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'You must login first',
      );
      return;
    }

    if (request.id == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid request selected',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final feedback = FeedbackModel(
        requestId: request.id!,
        requestTitle: request.title,
        userName: user.name,
        userEmail: user.email,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now().toIso8601String(),
      );

      await _repository.createFeedback(feedback);

      final result = await _repository.getAllFeedback();

      state = FeedbackState(
        feedbackList: result.data,
        isLoading: false,
        fromCache: true,
      );
    } catch (e) {
      state = FeedbackState(
        feedbackList: const [],
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> deleteFeedback(int id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.deleteFeedback(id);
      await loadAllFeedback();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}