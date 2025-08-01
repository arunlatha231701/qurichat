import 'package:flutter/material.dart';
import 'package:qurinomchat/presentation/viewmodels/auth_viewmodel.dart';
import 'package:qurinomchat/presentation/views/auth/login_view.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';

class RoleSelectionCard extends StatelessWidget {
  final String role;
  final IconData icon;
  final String description;

  const RoleSelectionCard({
    required this.role,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LoginView(
                role: role,
                viewModel: AuthViewModel(),
                emailController: TextEditingController(),
                passwordController: TextEditingController(),
                formKey: GlobalKey<FormState>(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                role,
                style: AppTextStyles.headline2,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyles.body2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}