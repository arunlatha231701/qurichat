import 'package:bloc/bloc.dart';
import 'package:qurinomchat/domain/usecases/auth/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;

  AuthBloc(this._loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final result = await _loginUseCase.execute(
        event.email,
        event.password,
        event.role,
      );

      emit(AuthSuccess(
        token: result.token,
        userId: result.userId,
        role: result.role,
        email: result.email,
        name: result.name,
      ));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

}