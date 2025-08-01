import 'package:qurinomchat/data/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<void> execute() async {
    await _authRepository.logout();
  }
}