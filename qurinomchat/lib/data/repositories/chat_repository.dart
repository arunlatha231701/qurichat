import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:qurinomchat/data/models/chat/message_model.dart';
import 'package:qurinomchat/data/models/chat/send_message_request.dart';
import 'package:qurinomchat/core/network/api_client.dart';
import 'package:qurinomchat/core/constants/api_routes.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';

class ChatRepository {
  final ApiClient _apiClient;
  late IO.Socket _socket;

  ChatRepository(this._apiClient) {
    _initSocket();
  }

  void _initSocket() {
    _socket = IO.io(
      ApiRoutes.sendMessage,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }

  Future<List<ChatModel>> getUserChats(String userId) async {
    try {
      final response = await _apiClient.get(ApiRoutes.getUserChats(userId));
      return (response.data as List<dynamic>)
          .map((chat) => ChatModel.fromJson(chat as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load chats: ${e.toString()}');
    }
  }

  Future<List<MessageModel>> getMessages(String chatId) async {
    try {
      final response = await _apiClient.get(ApiRoutes.getMessages(chatId));
      return (response.data as List<dynamic>)
          .map((msg) => MessageModel.fromJson(msg as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load messages: ${e.toString()}');
    }
  }

  Future<void> sendMessage(SendMessageRequest request) async {
    try {

      _socket.emit('send_message', request.toJson());


      await _apiClient.post(
        ApiRoutes.sendMessage,
        data: request.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }

  void listenForNewMessages(void Function(MessageModel) onNewMessage) {
    _socket.on('new_message', (data) {
      final message = MessageModel.fromJson(data as Map<String, dynamic>);
      onNewMessage(message);
    });
  }

  void dispose() {
    _socket.disconnect();
  }
}