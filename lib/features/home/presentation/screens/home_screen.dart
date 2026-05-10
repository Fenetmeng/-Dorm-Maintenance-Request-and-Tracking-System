import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/stat_card_widget.dart';
import '../widgets/recent_request_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                           GestureDetector(
                            onTap: () {
                              context.go('/profile');
                            },
                            child: const CircleAvatar(
                             radius: 34,
                             backgroundColor: AppColors.lightBlue,
                             child: Icon(
                                 Icons.person,
                                 color: AppColors.primaryBlue,
                                 size: 34,
                               ),
                            ),
                         ),
                            const SizedBox(width: 18),
                            const Text(
                              'Welcome, Hana',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 36),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            StatCardWidget(
                              number: '4',
                              label: 'Total Requests',
                              numberColor: AppColors.primaryBlue,
                            ),
                            StatCardWidget(
                              number: '2',
                              label: 'Pending',
                              numberColor: Color(0xFFF2B705),
                            ),
                            StatCardWidget(
                              number: '2',
                              label: 'Completed',
                              numberColor: Color(0xFF22C55E),
                            ),
                          ],
                        ),

                        const SizedBox(height: 34),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/new-request');
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
                              '+  New Request',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 34),

                        const Text(
                          'Recent Requests',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                          ),
                        ),

                        const SizedBox(height: 22),

                        RecentRequestCard(
                          title: 'Leaking Faucet',
                          location: 'Block 5 - Room 101   April 18',
                          status: 'Pending',
                          statusColor: const Color(0xFFF2B705),
                          statusBackground: const Color(0xFFFFF6D8),
                          onTap: () {
                            context.go('/request-details');
                          },
                        ),

                        RecentRequestCard(
                          title: 'Broken Bed',
                          location: 'Block 5 - Room 101   April 1',
                          status: 'Completed',
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