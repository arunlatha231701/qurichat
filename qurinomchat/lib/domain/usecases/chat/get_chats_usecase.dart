import 'package:qurinomchat/data/models/chat/chat_model.dart';
import 'package:qurinomchat/data/repositories/chat_repository.dart';



class GetChatsUseCase {
  final ChatRepository _chatRepository;

  GetChatsUseCase(this._chatRepository);

  Future<List<ChatModel>> execute(String userId) async {
    return await _chatRepository.getUserChats(userId);
  }
}