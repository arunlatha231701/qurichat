import 'package:equatable/equatable.dart';
import 'package:qurinomchat/data/models/chat/message_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChats extends ChatEvent {
  final String userId;

  const LoadChats({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadGroupChats extends ChatEvent {
  final String userId;

  const LoadGroupChats({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoadMessages extends ChatEvent {
  final String chatId;

  const LoadMessages({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String senderId;
  final String content;

  const SendMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
  });

  @override
  List<Object> get props => [chatId, senderId, content];
}


class NewMessageReceived extends ChatEvent {
  final MessageModel message;

  const NewMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}