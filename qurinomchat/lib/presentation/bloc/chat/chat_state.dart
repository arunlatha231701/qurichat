import 'package:equatable/equatable.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';
import 'package:qurinomchat/data/models/chat/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatsLoading extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<ChatModel> chats;

  const ChatsLoaded({required this.chats});

  @override
  List<Object> get props => [chats];
}

class MessagesLoading extends ChatState {
  final String chatId;

  const MessagesLoading(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class MessagesLoaded extends ChatState {
  final String chatId;
  final List<MessageModel> messages;

  const MessagesLoaded({required this.chatId, required this.messages});

  @override
  List<Object> get props => [chatId, messages];
}

class ChatError extends ChatState {
  final String chatId;
  final String message;

  const ChatError({required this.chatId, required this.message});

  @override
  List<Object> get props => [chatId, message];
}