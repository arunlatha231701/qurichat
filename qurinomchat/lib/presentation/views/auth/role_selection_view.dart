import 'package:flutter/material.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/presentation/widgets/animated/fade_animation.dart';
import 'package:qurinomchat/presentation/widgets/animated/slide_animation.dart';
import 'package:qurinomchat/presentation/widgets/auth/role_selection_card.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [

              Container(
                height: 300,
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
                            'Welcome to ChatApp',
                            style: AppTextStyles.headline1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Select your role to continue',
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
              // Role selection cards
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    SlideAnimation(
                      offset: const Offset(-50, 0),
                      child: const FadeAnimation(
                        delay: 0.3,
                        child: RoleSelectionCard(
                          role: 'Customer',
                          icon: Icons.person_rounded,
                          description: 'I want to connect with vendors',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SlideAnimation(
                      offset: const Offset(50, 0),
                      child: const FadeAnimation(
                        delay: 0.4,
                        child: RoleSelectionCard(
                          role: 'Vendor',
                          icon: Icons.store_rounded,
                          description: 'I provide products/services',
                        ),
                      ),
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