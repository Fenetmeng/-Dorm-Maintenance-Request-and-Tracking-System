import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/google_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                    vertical: 28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 20),

                      const AuthTextField(
                        label: 'Name',
                        hintText: 'Enter your name',
                      ),
                      const SizedBox(height: 14),

                      const AuthTextField(
                        label: 'Email Address',
                        hintText: 'Enter your email address',
                      ),
                      const SizedBox(height: 14),

                      const AuthTextField(
                        label: 'Password',
                        hintText: 'Create a password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 14),

                      const AuthTextField(
                        label: 'Confirm Password',
                        hintText: 'Confirm password',
                        obscureText: true,
                      ),

                      const SizedBox(height: 26),

                      AuthButton(
                        text: 'SIGN UP',
                        onPressed: () {
                          context.go('/login');
                        },
                      ),

                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/login');
                            },
                            child: const Text(
                              ' Log In',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

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

                      const SizedBox(height: 20),

                      const GoogleButton(
                        text: 'Sign up with Google',
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