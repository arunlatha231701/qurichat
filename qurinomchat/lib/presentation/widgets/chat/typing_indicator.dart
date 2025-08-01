import 'package:flutter/material.dart';
import 'package:qurinomchat/core/constants/colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator();

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _animation1,
          child: _buildDot(),
        ),
        const SizedBox(width: 4),
        ScaleTransition(
          scale: _animation2,
          child: _buildDot(),
        ),
        const SizedBox(width: 4),
        ScaleTransition(
          scale: _animation3,
          child: _buildDot(),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.typingIndicator,
        shape: BoxShape.circle,
      ),
    );
  }
}