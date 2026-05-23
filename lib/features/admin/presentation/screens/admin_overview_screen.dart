import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/admin_provider.dart';
import '../widgets/admin_stat_card.dart';

class AdminOverviewScreen extends ConsumerStatefulWidget {
  const AdminOverviewScreen({super.key});

  @override
  ConsumerState<AdminOverviewScreen> createState() =>
      _AdminOverviewScreenState();
}

class _AdminOverviewScreenState extends ConsumerState<AdminOverviewScreen> {
  bool isMenuOpen = false;

  static const Color adminDark = Color(0xFF0F172A);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(adminProvider.notifier).loadAdminData();
    });
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void closeMenu() {
    setState(() {
      isMenuOpen = false;
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
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: isMenuOpen ? 180 : 0,
                top: 0,
                bottom: 0,
                width: 390,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      color: const Color(0xFFD9E3EF),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 18,
                            left: 18,
                            child: IconButton(
                              onPressed: toggleMenu,
                              icon: Icon(
                                isMenuOpen ? Icons.close : Icons.menu,
                                color: adminDark,
                              ),
                            ),
                          ),
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.admin_panel_settings,
                                    color: adminDark,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 14),
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
                                padding:
                                    const EdgeInsets.fromLTRB(34, 34, 34, 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AdminStatCard(
                                          number: adminState.totalRequests
                                              .toString(),
                                          label: 'Total Requests',
                                          numberColor: AppColors.textBlack,
                                        ),
                                        AdminStatCard(
                                          number: adminState.pendingRequests
                                              .toString(),
                                          label: 'Pending',
                                          numberColor:
                                              const Color(0xFFF59E0B),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 24),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AdminStatCard(
                                          number: adminState.inProgressRequests
                                              .toString(),
                                          label: 'In Progress',
                                          numberColor:
                                              const Color(0xFFF97316),
                                        ),
                                        AdminStatCard(
                                          number: adminState.completedRequests
                                              .toString(),
                                          label: 'Completed',
                                          numberColor:
                                              const Color(0xFF22C55E),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          context.go('/admin-requests');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: adminDark,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                          context.go('/all-feedback');
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: adminDark,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: const Text(
                                          'Review Feedback',
                                          style: TextStyle(
                                            color: adminDark,
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

              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: isMenuOpen ? 0 : -180,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.fromLTRB(18, 80, 18, 24),
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(3, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AdminMenuButton(
                        icon: Icons.dashboard_outlined,
                        text: 'Overview',
                        onTap: () {
                          closeMenu();
                          context.go('/admin-overview');
                        },
                      ),
                      AdminMenuButton(
                        icon: Icons.list_alt,
                        text: 'All Requests',
                        onTap: () {
                          closeMenu();
                          context.go('/admin-requests');
                        },
                      ),
                      AdminMenuButton(
                        icon: Icons.assignment_ind_outlined,
                        text: 'Assign Task',
                        onTap: () {
                          closeMenu();
                          context.go('/assign-task');
                        },
                      ),
                      AdminMenuButton(
                        icon: Icons.people_outline,
                        text: 'Staff Workload',
                        onTap: () {
                          closeMenu();
                          context.go('/staff-workload');
                        },
                      ),
                      AdminMenuButton(
                        icon: Icons.star_border,
                        text: 'Feedback',
                        onTap: () {
                          closeMenu();
                          context.go('/all-feedback');
                        },
                      ),

                      const Spacer(),

                      AdminMenuButton(
                        icon: Icons.logout,
                        text: 'Log out',
                        onTap: () {
                          ref.read(authProvider.notifier).logout();
                          context.go('/login');
                        },
                      ),
                    ],
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

class AdminMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const AdminMenuButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  static const Color adminDark = Color(0xFF0F172A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: adminDark,
          foregroundColor: Colors.white,
          elevation: 0,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}