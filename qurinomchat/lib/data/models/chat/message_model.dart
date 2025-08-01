import 'package:intl/intl.dart';

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;
  final String? fileName;
  final List<String> deletedBy;
  final String status;
  final DateTime? sentAt;
  final DateTime? deliveredAt;
  final DateTime? seenAt;
  final List<String> seenBy;
  final List<dynamic> reactions;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
    this.fileName,
    required this.deletedBy,
    required this.status,
    this.sentAt,
    this.deliveredAt,
    this.seenAt,
    required this.seenBy,
    required this.reactions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id']?.toString() ?? '',
      chatId: json['chatId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      messageType: json['messageType']?.toString() ?? 'text',
      fileUrl: json['fileUrl']?.toString(),
      fileName: json['fileName']?.toString(),
      deletedBy: (json['deletedBy'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      status: json['status']?.toString() ?? 'sent',
      sentAt: json['sentAt'] != null ? DateTime.tryParse(json['sentAt'].toString()) : null,
      deliveredAt: json['deliveredAt'] != null ? DateTime.tryParse(json['deliveredAt'].toString()) : null,
      seenAt: json['seenAt'] != null ? DateTime.tryParse(json['seenAt'].toString()) : null,
      seenBy: (json['seenBy'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      reactions: json['reactions'] as List<dynamic>? ?? [],
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
    );
  }

  String get formattedTime {
    if (sentAt == null) return '';
    return DateFormat('h:mm a').format(sentAt!);
  }
}