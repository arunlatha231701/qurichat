import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurinomchat/presentation/views/auth/role_selection_view.dart';
import 'package:qurinomchat/data/models/chat/chat_model.dart';
import 'package:qurinomchat/core/constants/styles.dart';
import 'package:qurinomchat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:qurinomchat/presentation/widgets/animated/fade_animation.dart';
import 'package:qurinomchat/presentation/widgets/chat/chat_list_item.dart';
import 'package:qurinomchat/presentation/widgets/shared/app_bar.dart';
import 'package:qurinomchat/presentation/widgets/shared/loading.dart';
import 'package:qurinomchat/presentation/views/chat/chat_detail_view.dart';

class ChatListView extends StatefulWidget {
  final String userId;
  final String userRole;

  const ChatListView({
    required this.userId,
    required this.userRole,
    Key? key,
  }) : super(key: key);

  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  List<ChatModel> _filteredChats = [];
  bool _isSearching = false;
  FocusNode _searchFocusNode = FocusNode();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ChatViewModel>(context, listen: false);
      viewModel.loadChats(widget.userId, context);
    });

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
        setState(() => _isSearching = false);
      }
    });
  }

  void _filterChats(String query, List<ChatModel> allChats) {
    setState(() {
      _filteredChats = allChats.where((chat) {

        final participant = chat.participants.firstWhere(
              (p) => p.id != widget.userId,
          orElse: () => Participant(
            location: Location(latitude: 0, longitude: 0),
            id: '',
            name: 'Unknown',
            email: '',
            role: '',
          ),
        );

        final nameMatch = participant.name.toLowerCase().contains(query.toLowerCase());


        final lastMessageMatch = chat.lastMessage?.content.toLowerCase().contains(query.toLowerCase()) ?? false;

        return nameMatch || lastMessageMatch;
      }).toList();
    });
  }

  Future<void> _refreshChats() async {
    final viewModel = Provider.of<ChatViewModel>(context, listen: false);
    try {
      await viewModel.loadChats(widget.userId, context);
      if (_isSearching && _searchController.text.isNotEmpty) {
        _filterChats(_searchController.text, viewModel.chats);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh chats')),
      );
    }
  }

  String _getRecipientName(ChatModel chat) {
    try {
      if (chat.participants.isEmpty) return 'Unknown';

      final otherParticipant = chat.participants.firstWhere(
            (p) => p.id != widget.userId,
        orElse: () => Participant(
          location: Location(latitude: 0, longitude: 0),
          id: '',
          name: 'Unknown',
          email: '',
          role: '',
        ),
      );

      return otherParticipant.name;
    } catch (e) {
      return 'Unknown';
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _filterChats('', Provider.of<ChatViewModel>(context, listen: false).chats);
    _searchFocusNode.unfocus();
    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<ChatViewModel>(context);
    final chats = _isSearching ? _filteredChats : viewModel.chats;

    return WillPopScope(
      onWillPop: () async {

        return false;
      },
      child: Scaffold(
        appBar: _isSearching
            ? AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search chats...',
              border: InputBorder.none,
              hintStyle: AppTextStyles.body1.copyWith(color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearSearch,
              )
                  : null,
            ),
            style: AppTextStyles.body1,
            onChanged: (value) => _filterChats(value, viewModel.chats),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [

          ],
        )
            : CustomAppBar(
          title: 'Messages',
          leading: Container(),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                setState(() => _isSearching = true);
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const RoleSelectionView()),
                                (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: viewModel.isLoading && chats.isEmpty
            ? const Center(child: LoadingIndicator())
            : chats.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isSearching && _searchController.text.isNotEmpty
                    ? 'No matching chats found'
                    : 'No chats available',
                style: AppTextStyles.body1,
              ),
              TextButton(
                onPressed: _refreshChats,
                child: const Text('Refresh'),
              ),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: _refreshChats,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            itemCount: chats.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              indent: 80,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final chat = chats[index];
              return FadeAnimation(
                delay: (0.1 * index).clamp(0.0, 0.8),
                child: ChatListItem(
                  chat: chat,
                  currentUserId: widget.userId,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailView(
                          chatId: chat.id,
                          userId: widget.userId,
                          recipientName: _getRecipientName(chat),
                        ),
                      ),
                    ).then((_) {
                      _refreshChats();
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}