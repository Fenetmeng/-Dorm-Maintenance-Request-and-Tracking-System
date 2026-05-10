import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/widgets/auth_button.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';

class NewRequestScreen extends StatelessWidget {
  const NewRequestScreen({super.key});

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
                        context.go('/home');
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'New Request',
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
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthTextField(
                          label: 'Category',
                          hintText: 'Plumbing',
                        ),

                        const SizedBox(height: 18),

                        const AuthTextField(
                          label: 'Location',
                          hintText: 'Gibe Hall',
                        ),

                        const SizedBox(height: 18),

                        const AuthTextField(
                          label: 'Room Number',
                          hintText: 'Enter room number',
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
                                'Upload photo (optional)',
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
                          text: 'Submit Request',
                          onPressed: () {
                            context.go('/requests');
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