import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/feedback_card.dart';

class AllFeedbackScreen extends StatelessWidget {
  const AllFeedbackScreen({super.key});

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
                        context.go('/admin-overview');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ALL FEEDBACK',
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
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        FeedbackCard(
                          studentName: 'Hana Bekele',
                          requestTitle: 'Leaking Faucet',
                          rating: 5,
                          comment:
                              'The maintenance staff responded quickly and fixed the faucet properly.',
                        ),
                        FeedbackCard(
                          studentName: 'John Doe',
                          requestTitle: 'Broken AC Unit',
                          rating: 4,
                          comment:
                              'The issue was solved, but it took longer than expected.',
                        ),
                        FeedbackCard(
                          studentName: 'Sara Ali',
                          requestTitle: 'Broken Bed',
                          rating: 5,
                          comment:
                              'Very good service. The staff was polite and the repair was completed well.',
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