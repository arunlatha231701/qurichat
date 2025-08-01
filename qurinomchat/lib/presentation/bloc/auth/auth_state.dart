import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  final String userId;
  final String role;
  final String email;
  final String name;

  const AuthSuccess({
    required this.token,
    required this.userId,
    required this.role,
    required this.email,
    required this.name,
  });

  @override
  List<Object> get props => [token, userId, role, email, name];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}