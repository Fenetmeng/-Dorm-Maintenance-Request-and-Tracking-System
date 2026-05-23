import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../providers/feedback_provider.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  int rating = 0;
  final commentController = TextEditingController();

  MaintenanceRequestModel? selectedRequest;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      final extra = GoRouterState.of(context).extra;

      if (extra is MaintenanceRequestModel) {
        selectedRequest = extra;
      }

      isInitialized = true;
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    final request = selectedRequest;
    final comment = commentController.text.trim();

    if (request == null) {
      _showMessage('No completed request selected', isError: true);
      return;
    }

    if (rating == 0) {
      _showMessage('Please select a rating', isError: true);
      return;
    }

    if (comment.isEmpty) {
      _showMessage('Please write a comment', isError: true);
      return;
    }

    await ref.read(feedbackProvider.notifier).createFeedback(
          request: request,
          rating: rating,
          comment: comment,
        );

    if (!mounted) return;

    final feedbackState = ref.read(feedbackProvider);

    if (feedbackState.errorMessage != null) {
      _showMessage(feedbackState.errorMessage!, isError: true);
      return;
    }

    _showMessage('Feedback submitted successfully', isError: false);

    context.go('/requests');
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedbackState = ref.watch(feedbackProvider);

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
                        context.go('/requests');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'FEEDBACK',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),

                        const Text(
                          'Rate the Service',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          selectedRequest == null
                              ? 'Select a completed request first.'
                              : 'How was the maintenance service for "${selectedRequest!.title}"?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final starNumber = index + 1;

                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  rating = starNumber;
                                });
                              },
                              icon: Icon(
                                starNumber <= rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFF2B705),
                                size: 32,
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 28),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Additional Comments (Optional)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: commentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Tell us more about your experience...',
                            hintStyle: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFD6DDE8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 34),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: feedbackState.isLoading
                                ? null
                                : _submitFeedback,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: feedbackState.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Submit Feedback',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
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