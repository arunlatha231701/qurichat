import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:qurinomchat/domain/usecases/chat/get_chats_usecase.dart';
import 'package:qurinomchat/domain/usecases/chat/get_messages_usecase.dart';
import 'package:qurinomchat/domain/usecases/chat/send_message_usecase.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';
import 'package:qurinomchat/data/models/chat/message_model.dart';
import 'package:qurinomchat/data/models/chat/send_message_request.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_event.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase _getChatsUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  StreamSubscription? _messageSubscription;

  ChatBloc(
      this._getChatsUseCase,
      this._getMessagesUseCase,
      this._sendMessageUseCase,
      ) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<NewMessageReceived>(_onNewMessageReceived);

    _sendMessageUseCase.listenForNewMessages((message) {
      add(NewMessageReceived(message));
    });
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(ChatsLoading());
    try {
      final chats = await _getChatsUseCase.execute(event.userId);
      emit(ChatsLoaded(chats: chats));
    } catch (e) {
      emit(ChatError(message: e.toString(), chatId: ''));
    }
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(MessagesLoading(event.chatId));
    try {
      final messages = await _getMessagesUseCase.execute(event.chatId);
      emit(MessagesLoaded(chatId: event.chatId, messages: messages));
    } catch (e) {
      emit(ChatError(chatId: event.chatId, message: e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final request = SendMessageRequest(
        chatId: event.chatId,
        senderId: event.senderId,
        content: event.content,
      );
      await _sendMessageUseCase.execute(request);

      if (state is MessagesLoaded) {
        final currentState = state as MessagesLoaded;
        if (currentState.chatId == event.chatId) {
          final newMessage = MessageModel(
            id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
            chatId: event.chatId,
            senderId: event.senderId,
            content: event.content,
            messageType: 'text',
            fileUrl: null,
            fileName: null,
            deletedBy: [],
            status: 'sent',
            sentAt: DateTime.now(),
            deliveredAt: null,
            seenAt: null,
            seenBy: [],
            reactions: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          emit(MessagesLoaded(
            chatId: event.chatId,
            messages: [...currentState.messages, newMessage],
          ));
        }
      }
    } catch (e) {
      emit(ChatError(chatId: event.chatId, message: e.toString()));
    }
  }

  void _onNewMessageReceived(NewMessageReceived event, Emitter<ChatState> emit) {
    if (state is MessagesLoaded) {
      final currentState = state as MessagesLoaded;
      if (currentState.chatId == event.message.chatId) {
        emit(MessagesLoaded(
          chatId: event.message.chatId,
          messages: [...currentState.messages, event.message],
        ));
      }
    }

    if (state is ChatsLoaded) {
      final currentState = state as ChatsLoaded;
      final updatedChats = currentState.chats.map((chat) {
        if (chat.id == event.message.chatId) {
          return chat.copyWith(
            lastMessage: LastMessage(
              id: event.message.id,
              senderId: event.message.senderId,
              content: event.message.content,
              messageType: event.message.messageType,
              sentAt: event.message.sentAt,
            ),
            updatedAt: DateTime.now(),
          );
        }
        return chat;
      }).toList();
      emit(ChatsLoaded(chats: updatedChats));
    }
  }
}