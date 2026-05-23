import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../providers/admin_provider.dart';

class StaffWorkloadScreen extends ConsumerStatefulWidget {
  const StaffWorkloadScreen({super.key});

  @override
  ConsumerState<StaffWorkloadScreen> createState() =>
      _StaffWorkloadScreenState();
}

class _StaffWorkloadScreenState extends ConsumerState<StaffWorkloadScreen> {
  static const Color adminDark = Color(0xFF0F172A);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(adminProvider.notifier).loadAdminData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(adminProvider);

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
                        color: adminDark,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'STAFF WORKLOAD',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: adminDark,
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
                  child: adminState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                          child: Column(
                            children: [
                              if (adminState.staff.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Text(
                                    'No staff found.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                )
                              else
                                ...adminState.staff.map((staff) {
                                  final inProgress = ref
                                      .read(adminProvider.notifier)
                                      .workloadForStaff(staff.name);

                                  final completed = ref
                                      .read(adminProvider.notifier)
                                      .completedForStaff(staff.name);

                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 18),
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xFFE5E7EB),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.04),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${staff.name}  |  ${staff.role}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textBlack,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$inProgress In Progress',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFF59E0B),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '$completed Completed',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF22C55E),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
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