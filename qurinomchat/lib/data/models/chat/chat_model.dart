import 'package:intl/intl.dart';

class ChatModel {
  final String id;
  final bool isGroupChat;
  final List<Participant> participants;
  final LastMessage? lastMessage;
  final DateTime? updatedAt;
  final bool? isRead;

  ChatModel({
    required this.id,
    required this.isGroupChat,
    required this.participants,
    this.lastMessage,
    this.updatedAt,
    this.isRead,
  });


  ChatModel copyWith({
    String? id,
    bool? isGroupChat,
    List<Participant>? participants,
    LastMessage? lastMessage,
    DateTime? updatedAt,
    bool? isRead,
  }) {
    return ChatModel(
      id: id ?? this.id,
      isGroupChat: isGroupChat ?? this.isGroupChat,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
      isRead: isRead ?? this.isRead,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id']?.toString() ?? '',
      isGroupChat: json['isGroupChat'] as bool? ?? false,
      participants: (json['participants'] as List<dynamic>? ?? [])
          .map((p) => Participant.fromJson(p as Map<String, dynamic>))
          .toList(),
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now()
          : null,
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  String get formattedTime {
    if (lastMessage?.sentAt == null) return '';
    return DateFormat('h:mm a').format(lastMessage!.sentAt!);
  }
}

class LastMessage {
  final String id;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;
  final DateTime? sentAt;
  final DateTime? createdAt;

  LastMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
    this.sentAt,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      messageType: json['messageType']?.toString() ?? 'text',
      fileUrl: json['fileUrl']?.toString(),
      sentAt: json['sentAt'] != null
          ? DateTime.tryParse(json['sentAt'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}

class Participant {
  final Location location;
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profileImage;

  Participant({
    required this.location,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      location: Location.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'user',
      profileImage: json['profile']?.toString(),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}