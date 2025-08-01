import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_bloc.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_event.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_state.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatBloc _chatBloc;
  List<ChatModel> _chats = [];
  bool _isLoading = false;
  StreamSubscription? _chatSubscription;
  Completer<void>? _loadChatsCompleter;

  ChatViewModel(this._chatBloc);

  List<ChatModel> get chats => _chats;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _chatSubscription?.cancel();
    _loadChatsCompleter?.complete();
    super.dispose();
  }

  Future<void> loadChats(String userId, BuildContext context) {
    _isLoading = true;
    notifyListeners();
    _loadChatsCompleter = Completer<void>();

    _chatSubscription?.cancel();
    _chatSubscription = _chatBloc.stream.listen((state) {
      if (state is ChatsLoaded) {
        _chats = state.chats;
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
          _loadChatsCompleter?.complete();
        });
      } else if (state is ChatError) {
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
          _loadChatsCompleter?.complete();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        });
      }
    });

    _chatBloc.add(LoadChats(userId: userId));
    return _loadChatsCompleter!.future;
  }

  void loadMessages(String chatId, BuildContext context) {
    _chatBloc.add(LoadMessages(chatId: chatId));
  }

  void sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    required BuildContext context,
  }) {
    _chatBloc.add(SendMessage(
      chatId: chatId,
      senderId: senderId,
      content: content,
    ));
  }
}