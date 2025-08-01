import 'package:flutter/material.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onSend;

  const MessageInput({required this.onSend});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: AppTextStyles.body1.copyWith(
                    color: AppColors.textSecondary.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                ),
                style: AppTextStyles.body1,
                maxLines: 5,
                minLines: 1,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: _hasText ? 48 : 0,
            height: 48,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.white),
              onPressed: _hasText
                  ? () {
                widget.onSend(_controller.text.trim());
                _controller.clear();
              }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}