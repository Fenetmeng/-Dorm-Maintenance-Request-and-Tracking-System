import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/widgets/auth_button.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                        context.go(AppRoutes.home);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'PROFILE',
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 26, 28, 30),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 42,
                          backgroundColor: AppColors.lightBlue,
                          child: Icon(
                            Icons.person,
                            size: 42,
                            color: AppColors.primaryBlue,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Hana Bekele',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 32),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'My Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        const AuthTextField(
                          label: 'Full Name',
                          hintText: 'Hana Bekele',
                        ),

                        const SizedBox(height: 18),

                        const AuthTextField(
                          label: 'Phone Number',
                          hintText: '+251 912 345 678',
                        ),

                        const SizedBox(height: 28),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const AuthTextField(
                          label: 'Current Password',
                          hintText: 'Enter current password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 18),

                        const AuthTextField(
                          label: 'New Password',
                          hintText: 'Enter new password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 34),

                        AuthButton(
                           text: 'Done',
                           onPressed: () {
                            context.go(AppRoutes.home);
                          },
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(AppRoutes.welcome);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEF4444),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Delete Account',
                              style: TextStyle(
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
