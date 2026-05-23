import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/widgets/auth_button.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../domain/models/maintenance_request_model.dart';

class EditRequestScreen extends StatefulWidget {
  const EditRequestScreen({super.key});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final roomNumberController = TextEditingController();
  final descriptionController = TextEditingController();

  MaintenanceRequestModel? request;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      final extra = GoRouterState.of(context).extra;

      if (extra is MaintenanceRequestModel) {
        request = extra;

        categoryController.text = request!.category;
        locationController.text = request!.location;
        roomNumberController.text = request!.roomNumber;
        descriptionController.text = request!.description;
      }

      isInitialized = true;
    }
  }

  @override
  void dispose() {
    categoryController.dispose();
    locationController.dispose();
    roomNumberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _updateRequest() {
    if (request == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No request selected to edit'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedRequest = request!.copyWith(
      title: categoryController.text.trim(),
      category: categoryController.text.trim(),
      location: locationController.text.trim(),
      roomNumber: roomNumberController.text.trim(),
      description: descriptionController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Request updated successfully'),
        backgroundColor: Colors.green,
      ),
    );

    context.go('/request-details', extra: updatedRequest);
  }

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
                        if (request != null) {
                          context.go('/request-details', extra: request);
                        } else {
                          context.go('/requests');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'EDIT REQUEST',
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
                        AuthTextField(
                          label: 'Category',
                          hintText: 'Enter category',
                          controller: categoryController,
                        ),

                        const SizedBox(height: 18),

                        AuthTextField(
                          label: 'Location',
                          hintText: 'Enter location',
                          controller: locationController,
                        ),

                        const SizedBox(height: 18),

                        AuthTextField(
                          label: 'Room Number',
                          hintText: 'Enter room number',
                          controller: roomNumberController,
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: descriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Describe the issue in detail...',
                            hintStyle: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFD6DDE8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Center(
                          child: Container(
                            width: 170,
                            height: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5E5E5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                'Change photo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 34),

                        AuthButton(
                          text: 'Update Request',
                          onPressed: _updateRequest,
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              context.go('/requests');
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
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
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