

import 'package:qurinomchat/data/models/chat/message_model.dart';
import 'package:qurinomchat/data/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _chatRepository;

  GetMessagesUseCase(this._chatRepository);

  Future<List<MessageModel>> execute(String chatId) async {
    return await _chatRepository.getMessages(chatId);
  }
}