import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: Container(
          width: 390,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: AppColors.lightBlue,
                child: Center(
                  child: Image.asset(
                    'assets/images/dormfix_logo.png',
                    width: 90,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 56,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forgot your password',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 12),

                      const Text(
                        'Enter your email address and we will help you reset your password.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textBlack,
                        ),
                      ),

                      const SizedBox(height: 42),

                      const AuthTextField(
                        label: 'Email Address',
                        hintText: 'Enter your email',
                      ),

                      const SizedBox(height: 36),

                      AuthButton(
                        text: 'Reset password',
                        onPressed: () {},
                      ),

                      const SizedBox(height: 18),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'Back to login',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 14,
                            ),
                          ),
                        ),
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