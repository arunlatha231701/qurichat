import 'package:qurinomchat/data/models/chat/send_message_request.dart';
import 'package:qurinomchat/data/repositories/chat_repository.dart';

import 'package:qurinomchat/data/models/chat/message_model.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<void> execute(SendMessageRequest request) async {
    await _chatRepository.sendMessage(request);
  }

  void listenForNewMessages(void Function(MessageModel) onNewMessage) {
    _chatRepository.listenForNewMessages(onNewMessage);
  }
}