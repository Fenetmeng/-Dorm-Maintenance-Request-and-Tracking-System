import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../requests/presentation/providers/request_provider.dart';
import '../widgets/recent_request_card.dart';
import '../widgets/stat_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(requestProvider.notifier).loadUserRequests();
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

  Color _statusColor(String status) {
    final lowerStatus = status.toLowerCase();

    if (lowerStatus.contains('completed')) {
      return const Color(0xFF22C55E);
    }

    if (lowerStatus.contains('progress')) {
      return const Color(0xFFF59E0B);
    }

    return const Color(0xFFF2B705);
  }

  Color _statusBackground(String status) {
    final lowerStatus = status.toLowerCase();

    if (lowerStatus.contains('completed')) {
      return const Color(0xFFDFF8E8);
    }

    return const Color(0xFFFFF6D8);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final requestState = ref.watch(requestProvider);

    final user = authState.currentUser;
    final userName = user?.name ?? 'User';

    final dashboardRequests = requestState.requests;

    final totalRequests = dashboardRequests.length;

    final pendingRequests = dashboardRequests.where((request) {
      return request.status.toLowerCase() == 'pending';
    }).length;

    final completedRequests = dashboardRequests.where((request) {
      return request.status.toLowerCase() == 'completed';
    }).length;

    final recentRequests = dashboardRequests.reversed.take(2).toList();

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
                      height: 72,
                      width: double.infinity,
                      color: AppColors.lightBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: toggleMenu,
                            icon: Icon(
                              isMenuOpen ? Icons.close : Icons.menu,
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
                                  Text(
                                    'Welcome, $userName',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 36),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StatCardWidget(
                                    number: totalRequests.toString(),
                                    label: 'Total Requests',
                                    numberColor: AppColors.primaryBlue,
                                  ),
                                  StatCardWidget(
                                    number: pendingRequests.toString(),
                                    label: 'Pending',
                                    numberColor: const Color(0xFFF2B705),
                                  ),
                                  StatCardWidget(
                                    number: completedRequests.toString(),
                                    label: 'Completed',
                                    numberColor: const Color(0xFF22C55E),
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

                              if (requestState.isLoading)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (recentRequests.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'No requests yet. Create a new request to see it here.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                )
                              else
                                ...recentRequests.map((request) {
                                  return RecentRequestCard(
                                    title: request.title,
                                    location:
                                        '${request.location} - Room ${request.roomNumber}   ${request.dateRequested.length >= 10 ? request.dateRequested.substring(0, 10) : request.dateRequested}',
                                    status: request.status,
                                    statusColor: _statusColor(request.status),
                                    statusBackground:
                                        _statusBackground(request.status),
                                    onTap: () {
                                      context.go(
                                        '/request-details',
                                        extra: request,
                                      );
                                    },
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
                      MenuButton(
                        icon: Icons.home_outlined,
                        text: 'Dashboard',
                        onTap: () {
                          closeMenu();
                          context.go('/home');
                        },
                      ),
                      MenuButton(
                        icon: Icons.description_outlined,
                        text: 'My Requests',
                        onTap: () {
                          closeMenu();
                          context.go('/requests');
                        },
                      ),
                      MenuButton(
                        icon: Icons.add,
                        text: 'New Request',
                        onTap: () {
                          closeMenu();
                          context.go('/new-request');
                        },
                      ),
                      MenuButton(
                        icon: Icons.person_outline,
                        text: 'My Account',
                        onTap: () {
                          closeMenu();
                          context.go('/profile');
                        },
                      ),
                      MenuButton(
                        icon: Icons.star_border,
                        text: 'Feedback',
                        onTap: () {
                          closeMenu();
                          context.go('/feedback');
                        },
                      ),

                      const Spacer(),

                      MenuButton(
                        icon: Icons.logout,
                        text: 'Log out',
                        onTap: () {
                          ref.read(authProvider.notifier).logout();
                          ref.read(requestProvider.notifier).clearRequests();
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

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

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
          backgroundColor: AppColors.primaryBlue,
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