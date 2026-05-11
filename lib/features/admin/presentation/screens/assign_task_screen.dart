import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';

class AssignTaskScreen extends StatelessWidget {
  const AssignTaskScreen({super.key});

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
                        context.go(AppRoutes.adminRequests);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ASSIGN TASK',
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
                    padding: const EdgeInsets.fromLTRB(28, 32, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Leaking Faucet',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Requested by: John Doe',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF555555),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Location: Dorm A - 101',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF555555),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Date: Oct 24, 2023',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 34),

                        const Text(
                          'Assign Maintenance Staff',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: 8),

                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Select staff member...',
                            hintStyle: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.grey,
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

                        const SizedBox(height: 28),

                        const Text(
                          'Update Request Status',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: 8),

                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Pending',
                            hintStyle: const TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 14,
                            ),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.grey,
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

                        const SizedBox(height: 170),

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
                              'Assign & Update Task',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.go(AppRoutes.staffWorkload);
                            },
                            child: const Text(
                              'View Staff Workload',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
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
