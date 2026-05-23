import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/google_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Please fill all fields');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Passwords do not match');
      return;
    }

    await ref.read(authProvider.notifier).signup(
          name: name,
          email: email,
          password: password,
          role: 'user',
        );

    final authState = ref.read(authProvider);

    if (authState.errorMessage != null) {
      _showMessage(authState.errorMessage!);
      return;
    }
     if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Account created successfully. Please log in.'),
    backgroundColor: Colors.green,
  ),
);

context.go('/login');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
                        AuthTextField(
                          label: 'Name',
                          hintText: 'Enter your name',
                          controller: nameController,
                        ),
                        const SizedBox(height: 14),
                        AuthTextField(
                          label: 'Email Address',
                          hintText: 'Enter your email address',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        AuthTextField(
                          label: 'Password',
                          hintText: 'Create a password',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 14),
                        AuthTextField(
                          label: 'Confirm Password',
                          hintText: 'Confirm password',
                          controller: confirmPasswordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 26),
                        authState.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AuthButton(
                                text: 'SIGN UP',
                                onPressed: _signup,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}