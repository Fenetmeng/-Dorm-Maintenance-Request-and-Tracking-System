import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/recent_request_card.dart';
import '../providers/request_provider.dart';

class RequestListScreen extends ConsumerStatefulWidget {
  const RequestListScreen({super.key});

  @override
  ConsumerState<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends ConsumerState<RequestListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(requestProvider.notifier).loadUserRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(requestProvider);
    final requests = requestState.requests;

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: SizedBox(
          width: 390,
          height: double.infinity,
          child: Column(
            children: [
              // Header (same as before)
              Container(
                height: 72,
                width: double.infinity,
                color: AppColors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/home'),
                      icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
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
                  child: requestState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(28, 24, 28, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Search and Filter (same UI)
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search requests...',
                                  prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                                  hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: AppColors.primaryBlue),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Filter: All Requests', style: TextStyle(fontSize: 13)),
                                ),
                              ),

                              const SizedBox(height: 24),

                              if (requests.isEmpty)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Text('No requests yet'),
                                  ),
                                )
                              else
                                ...requests.map((req) => RecentRequestCard(
                                      title: req.title,
                                      location: '${req.location} - Room ${req.roomNumber}\n${req.dateRequested.substring(0,10)}',
                                      status: req.status,
                                      statusColor: req.status == 'Pending' ? const Color(0xFFF2B705) : const Color(0xFF22C55E),
                                      statusBackground: req.status == 'Pending' ? const Color(0xFFFFF6D8) : const Color(0xFFDFF8E8),
                                      onTap: () => context.go('/request-details'),
                                    )),
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