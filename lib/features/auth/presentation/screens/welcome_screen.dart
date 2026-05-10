import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              // Top light blue space
              Container(
                height: 145,
                width: double.infinity,
                color: AppColors.lightBlue,
              ),

              // White middle section with circular logo
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                           width: 260,
                           height: 260,
                           color: const Color(0xFFEAF3FF),
                           child: Image.asset(
                              'assets/images/dormfix_logo.png',
                             width: 260,
                             height: 260,
                           fit: BoxFit.cover,
                         ),
                       ),
                    ),

                      const SizedBox(height: 18),

                      const Text(
                        'Report and track dorm maintenance easily',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom light blue section with buttons
              Container(
                width: double.infinity,
                color: AppColors.lightBlue,
                padding: const EdgeInsets.fromLTRB(32, 44, 32, 52),
                child: Column(
                  children: [
                    AuthButton(
                      text: 'Get Started',
                      onPressed: () {
                        context.go('/signup');
                      },
                    ),

                    const SizedBox(height: 36),

                    AuthButton(
                      text: 'Login',
                      onPressed: () {
                        context.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}