import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_state.dart';
import 'chat/chat_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return ChatListView(
            userId: state.userId, userRole: '',
          );
        } else if (state is AuthFailure) {
          return Scaffold(
            body: Center(
              child: Text('Login failed: ${state.error}'),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}