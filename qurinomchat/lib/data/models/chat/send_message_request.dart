class SendMessageRequest {
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String fileUrl;

  SendMessageRequest({
    required this.chatId,
    required this.senderId,
    required this.content,
    this.messageType = 'text',
    this.fileUrl = '',
  });

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'senderId': senderId,
    'content': content,
    'messageType': messageType,
    'fileUrl': fileUrl,
  };
}