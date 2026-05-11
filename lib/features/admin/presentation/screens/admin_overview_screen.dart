import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/admin_stat_card.dart';

class AdminOverviewScreen extends StatelessWidget {
  const AdminOverviewScreen({super.key});

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
                height: 150,
                width: double.infinity,
                color: const Color(0xFFD9E3EF),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.admin_panel_settings,
                        color: AppColors.primaryBlue,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Admin Overview',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(34, 34, 34, 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            AdminStatCard(
                              number: '120',
                              label: 'Total Requests',
                              numberColor: AppColors.textBlack,
                            ),
                            AdminStatCard(
                              number: '45',
                              label: 'Pending',
                              numberColor: Color(0xFFF59E0B),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            AdminStatCard(
                              number: '30',
                              label: 'In Progress',
                              numberColor: Color(0xFFF97316),
                            ),
                            AdminStatCard(
                              number: '45',
                              label: 'Completed',
                              numberColor: Color(0xFF22C55E),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        Container(
                          width: double.infinity,
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                color: Colors.grey,
                                size: 34,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Activity Chart Placeholder',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(AppRoutes.adminRequests);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F172A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Manage All Requests',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              context.go(AppRoutes.allFeedback);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF0F172A),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Review Feedback',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        TextButton(
                          onPressed: () {
                            context.go(AppRoutes.home);
                          },
                          child: const Text(
                            'Back to User Dashboard',
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
