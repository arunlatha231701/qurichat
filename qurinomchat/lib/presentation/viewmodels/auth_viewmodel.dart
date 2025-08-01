import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_bloc.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_event.dart';


class AuthViewModel {
  void login(String email, String password, String role, BuildContext context) {
    context.read<AuthBloc>().add(
      LoginRequested(
        email: email,
        password: password,
        role: role,
      ),
    );
  }
}