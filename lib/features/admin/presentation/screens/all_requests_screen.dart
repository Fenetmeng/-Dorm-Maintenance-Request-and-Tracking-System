import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../providers/admin_provider.dart';

class AllRequestsScreen extends ConsumerStatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  ConsumerState<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends ConsumerState<AllRequestsScreen> {
  static const Color adminDark = Color(0xFF0F172A);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(adminProvider.notifier).loadAdminData();
    });
  }

  Color _statusColor(String status) {
    final lower = status.toLowerCase();

    if (lower.contains('completed')) {
      return const Color(0xFF22C55E);
    }

    if (lower.contains('progress')) {
      return const Color(0xFFF59E0B);
    }

    return const Color(0xFFF2B705);
  }

  Color _statusBackground(String status) {
    final lower = status.toLowerCase();

    if (lower.contains('completed')) {
      return const Color(0xFFDFF8E8);
    }

    return const Color(0xFFFFF6D8);
  }

  String _assignedStaffForRequest(int? requestId) {
    if (requestId == null) return 'Unassigned';

    final adminState = ref.read(adminProvider);

    final matches = adminState.assignments.where((assignment) {
      return assignment.requestId == requestId;
    }).toList();

    if (matches.isEmpty) return 'Unassigned';

    return 'Staff: ${matches.first.staffName}';
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(adminProvider);
    final requests = adminState.requests;

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
                          'ALL REQUESTS',
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
                          padding: const EdgeInsets.fromLTRB(28, 26, 28, 30),
                          child: Column(
                            children: [
                              if (requests.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Text(
                                    'No requests found yet.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                )
                              else
                                ...requests.map((request) {
                                  final assignedText =
                                      _assignedStaffForRequest(request.id);

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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                request.title,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.textBlack,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _statusBackground(
                                                  request.status,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                request.status,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: _statusColor(
                                                    request.status,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          '${request.userEmail} • ${request.location} - ${request.roomNumber}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF666666),
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          assignedText,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: assignedText == 'Unassigned'
                                                ? Colors.red
                                                : AppColors.primaryBlue,
                                          ),
                                        ),

                                        const SizedBox(height: 14),

                                        SizedBox(
                                          width: double.infinity,
                                          height: 42,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              context.go(
                                                '/assign-task',
                                                extra: request,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: adminDark,
                                              foregroundColor: Colors.white,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              'Assign / Update',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
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