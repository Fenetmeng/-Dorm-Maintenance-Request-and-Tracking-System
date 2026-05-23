import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../feedback/domain/models/feedback_model.dart';
import '../../../feedback/presentation/providers/feedback_provider.dart';

class AllFeedbackScreen extends ConsumerStatefulWidget {
  const AllFeedbackScreen({super.key});

  @override
  ConsumerState<AllFeedbackScreen> createState() => _AllFeedbackScreenState();
}

class _AllFeedbackScreenState extends ConsumerState<AllFeedbackScreen> {
  static const Color adminDark = Color(0xFF0F172A);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedbackProvider.notifier).loadAllFeedback();
    });
  }

  String _stars(int rating) {
    final safeRating = rating.clamp(0, 5);
    final filledStars = '★' * safeRating;
    final emptyStars = '☆' * (5 - safeRating);
    return '$filledStars$emptyStars';
  }

  Widget _feedbackCard(FeedbackModel feedback) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.lightBlue,
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryBlue,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  feedback.userName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
              ),

              Text(
                _stars(feedback.rating),
                style: const TextStyle(
                  color: Color(0xFFF2B705),
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            feedback.requestTitle,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlue,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            feedback.userEmail,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.grey,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            feedback.comment,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF555555),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            feedback.createdAt.length >= 10
                ? feedback.createdAt.substring(0, 10)
                : feedback.createdAt,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedbackState = ref.watch(feedbackProvider);
    final feedbackList = feedbackState.feedbackList;

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: SizedBox(
          width: 390,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: 72,
                width: double.infinity,
                color: AppColors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go(AppRoutes.adminOverview);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: adminDark,
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          'ALL FEEDBACK',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: adminDark,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        ref.read(feedbackProvider.notifier).loadAllFeedback();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: adminDark,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: feedbackState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                          child: Column(
                            children: [
                              if (feedbackState.errorMessage != null)
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 18),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE4E4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    feedbackState.errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                              if (feedbackList.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 70),
                                  child: Text(
                                    'No feedback submitted yet.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                )
                              else
                                ...feedbackList.map(_feedbackCard),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
