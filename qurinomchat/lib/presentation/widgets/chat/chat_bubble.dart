import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/data/models/chat/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final bool showTime;

  const ChatBubble({
    required this.message,
    required this.isMe,
    this.showTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: isMe ? 80 : 16,
            right: isMe ? 16 : 80,
            top: 8,
            bottom: 4,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 16 : 0),
              topRight: Radius.circular(isMe ? 0 : 16),
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: AppTextStyles.body1.copyWith(
                  color: isMe ? Colors.white : AppColors.textPrimary,
                ),
              ),
              if (showTime)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    timeago.format(message.sentAt ?? DateTime.now()),
                    style: AppTextStyles.caption.copyWith(
                      color: isMe
                          ? Colors.white.withOpacity(0.8)
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}