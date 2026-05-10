import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../home/presentation/widgets/recent_request_card.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'MY REQUESTS',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
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
                    padding: const EdgeInsets.fromLTRB(28, 24, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search requests...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.grey,
                            ),
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
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Filter: All Requests',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        RecentRequestCard(
                          title: 'Leaking Faucet',
                          location: 'Dorm A - Room 101\nOct 24, 2023',
                          status: 'Pending',
                          statusColor: const Color(0xFFF2B705),
                          statusBackground: const Color(0xFFFFF6D8),
                          onTap: () {
                            context.go('/request-details');
                          },
                        ),

                        RecentRequestCard(
                          title: 'Broken Blinds',
                          location: 'Dorm A - Room 104\nOct 20, 2023',
                          status: 'In Progress',
                          statusColor: const Color(0xFFF59E0B),
                          statusBackground: const Color(0xFFFFF6D8),
                          onTap: () {
                            context.go('/request-details');
                          },
                        ),

                        RecentRequestCard(
                          title: 'AC Not Cooling',
                          location: 'Dorm A - Room 125\nOct 15, 2023',
                          status: 'Complete',
                          statusColor: const Color(0xFF22C55E),
                          statusBackground: const Color(0xFFDFF8E8),
                          onTap: () {
                            context.go('/request-details');
                          },
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