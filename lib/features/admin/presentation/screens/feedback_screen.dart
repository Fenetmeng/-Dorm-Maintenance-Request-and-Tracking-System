import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        context.go(AppRoutes.requestDetails);
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
                            color: AppColors.textBlack,
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
                    padding: const EdgeInsets.fromLTRB(28, 40, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Rate Service',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'How was the maintenance service?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF555555),
                          ),
                        ),

                        const SizedBox(height: 36),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.star, color: Color(0xFFF2B705), size: 36),
                            SizedBox(width: 6),
                            Icon(Icons.star, color: Color(0xFFF2B705), size: 36),
                            SizedBox(width: 6),
                            Icon(Icons.star, color: Color(0xFFF2B705), size: 36),
                            SizedBox(width: 6),
                            Icon(Icons.star, color: Color(0xFFF2B705), size: 36),
                            SizedBox(width: 6),
                            Icon(Icons.star_border,
                                color: Color(0xFFF2B705), size: 36),
                          ],
                        ),

                        const SizedBox(height: 38),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Comment',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Write your feedback here...',
                            hintStyle: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
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

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(AppRoutes.home);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Submit Feedback',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextButton(
                          onPressed: () {
                            context.go(AppRoutes.home);
                          },
                          child: const Text(
                            'Skip for now',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 13,
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
