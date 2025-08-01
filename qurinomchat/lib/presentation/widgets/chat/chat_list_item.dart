import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel chat;
  final String currentUserId;
  final VoidCallback onTap;

  const ChatListItem({
    required this.chat,
    required this.currentUserId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.lastMessage;
    final lastMessageContent = lastMessage?.content ?? 'No messages yet';
    final isSentByMe = lastMessage?.senderId == currentUserId;
    final isRead = chat.isRead ?? false;

    final participant = chat.participants.firstWhere(
          (p) => p.id != currentUserId,
      orElse: () => Participant(
        location: Location(latitude: 0, longitude: 0),
        id: '',
        name: 'Unknown',
        email: '',
        role: '',
      ),
    );

    final timeText = lastMessage?.sentAt != null
        ? timeago.format(lastMessage!.sentAt!)
        : '';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary,
              backgroundImage: participant.profileImage != null
                  ? NetworkImage(participant.profileImage!)
                  : null,
              child: participant.profileImage == null
                  ? const Icon(
                Icons.person_rounded,
                size: 30,
                color: Colors.white,
              )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        participant.name,
                        style: AppTextStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          isSentByMe ? 'You: $lastMessageContent' : lastMessageContent,
                          style: AppTextStyles.body2.copyWith(
                            fontWeight: isRead ? FontWeight.normal : FontWeight.w500,
                            color: isRead
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        timeText,
                        style: AppTextStyles.caption.copyWith(
                          color: isRead
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}