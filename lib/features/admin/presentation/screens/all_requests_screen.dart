import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/admin_request_card.dart';

class AllRequestsScreen extends StatelessWidget {
  const AllRequestsScreen({super.key});

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
                        Icons.menu,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ALL REQUESTS',
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
                    padding: const EdgeInsets.fromLTRB(28, 24, 28, 30),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by user, location, status...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.grey,
                            ),
                            hintStyle: const TextStyle(
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
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

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 44,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Status: All',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: 44,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Location: All',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        AdminRequestCard(
                          title: 'Leaking Faucet',
                          student: 'John D.',
                          location: 'Dorm A-101',
                          status: 'Pending',
                          assignedTo: 'Unassigned',
                          onTap: () {
                            context.go('/assign-task');
                          },
                        ),

                        AdminRequestCard(
                          title: 'Broken AC Unit',
                          student: 'Jane S.',
                          location: 'Dorm B-205',
                          status: 'In Progress',
                          assignedTo: 'Staff: Mike R.',
                          onTap: () {
                            context.go('/assign-task');
                          },
                        ),

                        AdminRequestCard(
                          title: 'Shower Drain Clogged',
                          student: 'Alex J.',
                          location: 'Dorm C-302',
                          status: 'Pending',
                          assignedTo: 'Unassigned',
                          onTap: () {
                            context.go('/assign-task');
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