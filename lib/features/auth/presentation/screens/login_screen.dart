import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/google_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 36,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack,
                          ),
                        ),

                        const SizedBox(height: 24),

                        const AuthTextField(
                          label: 'Email Address',
                          hintText: 'Enter your email',
                        ),

                        const SizedBox(height: 18),

                        const AuthTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.go(AppRoutes.forgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        AuthButton(
                          text: 'LOG IN',
                          onPressed: () {
                            context.go(AppRoutes.home);
                          },
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {
                              context.go(AppRoutes.adminOverview);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primaryBlue,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Admin Demo',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account?",
                              style: TextStyle(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go(AppRoutes.signup);
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: const [
                            Expanded(child: Divider(color: Colors.black54)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Or'),
                            ),
                            Expanded(child: Divider(color: Colors.black54)),
                          ],
                        ),

                        const SizedBox(height: 22),

                        const GoogleButton(
                          text: 'Sign in with Google',
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
