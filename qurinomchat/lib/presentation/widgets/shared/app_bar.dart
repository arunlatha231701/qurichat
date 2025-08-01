import 'package:flutter/material.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.headline2.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      leading: leading,
      actions: actions,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textPrimary,
      shape: const Border(
        bottom: BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}