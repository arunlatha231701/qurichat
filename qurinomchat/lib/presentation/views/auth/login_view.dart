import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_state.dart';
import 'package:qurinomchat/presentation/views/auth/role_selection_view.dart';
import 'package:qurinomchat/presentation/views/home_view.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/presentation/viewmodels/auth_viewmodel.dart';
import 'package:qurinomchat/presentation/widgets/animated/fade_animation.dart';
import 'package:qurinomchat/presentation/widgets/animated/slide_animation.dart';
import 'package:qurinomchat/presentation/widgets/auth/gradient_button.dart';
import 'package:qurinomchat/presentation/widgets/auth/input_field.dart';

class LoginView extends StatelessWidget {
  final String role;
  final AuthViewModel viewModel;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginView({
    required this.role,
    required this.viewModel,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionView()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>  HomeView(),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  // Header with gradient
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Center(
                      child: SlideAnimation(
                        offset: const Offset(0, -50),
                        child: FadeAnimation(
                          delay: 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.chat_bubble_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Welcome Back',
                                style: AppTextStyles.headline1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Login as $role',
                                style: AppTextStyles.subtitle1.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Form
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    child: Form(
                      key: formKey,
                      child: SlideAnimation(
                        offset: const Offset(0, 30),
                        child: FadeAnimation(
                          delay: 0.4,
                          child: Column(
                            children: [
                              InputField(
                                controller: emailController,
                                label: 'Email Address',
                                hint: 'your@email.com',
                                icon: Icons.email_rounded,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              InputField(
                                controller: passwordController,
                                label: 'Password',
                                hint: '••••••••',
                                icon: Icons.lock_rounded,
                                obscureText: true,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter your password';
                                  }
                                  if (value!.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return GradientButton(
                                    text: 'Login',
                                    isLoading: state is AuthLoading,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        viewModel.login(
                                          emailController.text,
                                          passwordController.text,
                                          role.toLowerCase(),
                                          context,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}