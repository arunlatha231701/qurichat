import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_bloc.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_state.dart';
import 'package:qurinomchat/presentation/widgets/shared/loading.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:qurinomchat/presentation/widgets/animated/slide_animation.dart';
import 'package:qurinomchat/presentation/widgets/chat/chat_bubble.dart';
import 'package:qurinomchat/presentation/widgets/chat/message_input.dart';
import 'package:qurinomchat/presentation/widgets/chat/typing_indicator.dart';
import 'package:qurinomchat/presentation/widgets/shared/app_bar.dart';

class ChatDetailView extends StatefulWidget {
  final String chatId;
  final String userId;
  final String recipientName;

  const ChatDetailView({
    required this.chatId,
    required this.userId,
    required this.recipientName,
  });

  @override
  _ChatDetailViewState createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ChatViewModel>(context, listen: false);
      viewModel.loadMessages(widget.chatId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: widget.recipientName,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          const CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is MessagesLoading && state.chatId == widget.chatId) {
                  return const Center(child: LoadingIndicator());
                } else if (state is MessagesLoaded && state.chatId == widget.chatId) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (_isTyping && index == state.messages.length) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          child: TypingIndicator(),
                        );
                      }

                      final message = state.messages[index];
                      return SlideAnimation(
                        offset: Offset(
                          message.senderId == widget.userId ? 50 : -50,
                          0,
                        ),
                        child: ChatBubble(
                          message: message,
                          isMe: message.senderId == widget.userId,
                          showTime: index == state.messages.length - 1 ||
                              (index < state.messages.length - 1 &&
                                  message.senderId !=
                                      state.messages[index + 1].senderId),
                        ),
                      );
                    },
                  );
                } else if (state is ChatError && state.chatId == widget.chatId) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyles.body1,
                    ),
                  );
                }
                return const Center(child: LoadingIndicator());
              },
            ),
          ),
          MessageInput(
            onSend: (message) {
              setState(() => _isTyping = true);
              Future.delayed(const Duration(seconds: 1), () {
                setState(() => _isTyping = false);
              });

              final viewModel = Provider.of<ChatViewModel>(context, listen: false);
              viewModel.sendMessage(
                chatId: widget.chatId,
                senderId: widget.userId,
                content: message,
                context: context,
              );
            },
          ),
        ],
      ),
    );
  }
}