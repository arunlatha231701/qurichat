import 'package:flutter/material.dart';
import 'package:qurinomchat/core/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}