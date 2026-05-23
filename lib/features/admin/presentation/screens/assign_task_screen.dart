import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../requests/domain/models/maintenance_request_model.dart';
import '../providers/admin_provider.dart';

class AssignTaskScreen extends ConsumerStatefulWidget {
  const AssignTaskScreen({super.key});

  @override
  ConsumerState<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends ConsumerState<AssignTaskScreen> {
  static const Color adminDark = Color(0xFF0F172A);

  MaintenanceRequestModel? selectedRequest;
  String? selectedStaffName;
  String? selectedStatus;

  final statusOptions = const [
    'Pending',
    'In Progress',
    'Completed',
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(adminProvider.notifier).loadAdminData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final extra = GoRouterState.of(context).extra;

    if (extra is MaintenanceRequestModel && selectedRequest == null) {
      selectedRequest = extra;
      selectedStatus = extra.status;
    }
  }

  Future<void> _assignAndUpdate() async {
    final request = selectedRequest;

    if (request == null || request.id == null) {
      _showMessage('No request selected', isError: true);
      return;
    }

    if (selectedStatus == null) {
      _showMessage('Please select status', isError: true);
      return;
    }

    final staffList = ref.read(adminProvider).staff;

    if (selectedStaffName != null && selectedStaffName!.isNotEmpty) {
      final selectedStaff = staffList.firstWhere(
        (staff) => staff.name == selectedStaffName,
      );

      await ref.read(adminProvider.notifier).assignStaffToRequest(
            requestId: request.id!,
            staffName: selectedStaff.name,
            staffRole: selectedStaff.role,
          );
    }

    await ref.read(adminProvider.notifier).updateRequestStatus(
          requestId: request.id!,
          status: selectedStatus!,
        );

    if (!mounted) return;

    _showMessage('Task updated successfully', isError: false);

    context.go('/admin-requests');
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(adminProvider);

    selectedRequest ??= adminState.requests.isNotEmpty
        ? adminState.requests.first
        : null;

    selectedStatus ??= selectedRequest?.status ?? 'Pending';

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
                        context.go('/admin-requests');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: adminDark,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ASSIGN TASK',
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
                          child: selectedRequest == null
                              ? const Center(
                                  child: Text(
                                    'No request selected',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                )
                              : Column(
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedRequest!.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textBlack,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Requested by: ${selectedRequest!.userEmail}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Location: ${selectedRequest!.location} - ${selectedRequest!.roomNumber}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Date: ${selectedRequest!.dateRequested.length >= 10 ? selectedRequest!.dateRequested.substring(0, 10) : selectedRequest!.dateRequested}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 30),

                                    const Text(
                                      'Assign Maintenance Staff',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    DropdownButtonFormField<String>(
                                      value: selectedStaffName,
                                      hint: const Text('Select staff member...'),
                                      items: adminState.staff.map((staff) {
                                        return DropdownMenuItem<String>(
                                          value: staff.name,
                                          child: Text(
                                            '${staff.name} (${staff.role})',
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStaffName = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 14,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD6DDE8),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: adminDark,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 26),

                                    const Text(
                                      'Update Request Status',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textBlack,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    DropdownButtonFormField<String>(
                                      value: selectedStatus,
                                      items: statusOptions.map((status) {
                                        return DropdownMenuItem<String>(
                                          value: status,
                                          child: Text(status),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStatus = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 14,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFD6DDE8),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: adminDark,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 180),

                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: ElevatedButton(
                                        onPressed: _assignAndUpdate,
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
                                          'Assign & Update Task',
                                          style: TextStyle(
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
      ),
    );
  }
}