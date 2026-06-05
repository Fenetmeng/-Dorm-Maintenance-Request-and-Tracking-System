
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../domain/models/maintenance_request_model.dart';
import '../providers/request_provider.dart';

class RequestDetailsScreen extends ConsumerWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extra = GoRouterState.of(context).extra;

    final requestState = ref.watch(requestProvider);

    final MaintenanceRequestModel? request =
        extra is MaintenanceRequestModel
            ? extra
            : requestState.requests.isNotEmpty
                ? requestState.requests.first
                : null;

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
                        context.go('/requests');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'REQUEST DETAILS',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
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
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (request == null)
                          const Center(
                            child: Text(
                              'No request selected',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textBlack,
                              ),
                            ),
                          )
                        else ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        request.title,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _statusBackground(
                                          request.status,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        request.status,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _statusColor(request.status),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                DetailRow(
                                  label: 'Category',
                                  value: request.category,
                                ),
                                DetailRow(
                                  label: 'Location',
                                  value: request.location,
                                ),
                                DetailRow(
                                  label: 'Room Number',
                                  value: request.roomNumber,
                                ),
                                DetailRow(
                                  label: 'Submitted Date',
                                  value: request.dateRequested.length >= 10
                                      ? request.dateRequested.substring(0, 10)
                                      : request.dateRequested,
                                ),

                                const SizedBox(height: 18),

                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textBlack,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  request.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Color(0xFF555555),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                const Text(
                                  'Uploaded Photo',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textBlack,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E5E5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: request.imagePath == null ||
                                          request.imagePath!.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'No photo uploaded',
                                            style: TextStyle(
                                              color: Color(0xFF555555),
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
  request.imagePath!,
  width: double.infinity,
  height: 170,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return const Center(
      child: Text(
        'Could not load photo',
        style: TextStyle(
          color: Colors.red,
          fontSize: 13,
        ),
      ),
    );
  },
),
                                        ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                context.go('/edit-request', extra: request);
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
                                'Edit Request',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          if (request.status.toLowerCase() ==
                              'completed') ...[
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.go('/feedback', extra: request);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF22C55E),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Leave Feedback',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Request?'),
                                      content: const Text(
                                        'This action cannot be undone.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true && request.id != null) {
                                  await ref
                                      .read(requestProvider.notifier)
                                      .deleteRequest(request.id!);

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Request deleted successfully',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    context.go('/requests');
                                  }
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.red,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Delete Request',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              onPressed: () {
                                context.go('/requests');
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.primaryBlue,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Back to Requests',
                                style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }
}