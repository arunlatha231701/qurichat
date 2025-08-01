
import 'package:qurinomchat/data/models/auth/login_request.dart';
import 'package:qurinomchat/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<LoginResult> execute(String email, String password, String role) async {
    final request = LoginRequest(
      email: email,
      password: password,
      role: role,
    );

    final response = await _authRepository.login(request);

    return LoginResult(
      token: response.data.token,
      userId: response.data.user.id,
      role: response.data.user.role,
      email: response.data.user.email,
      name: response.data.user.name,
    );
  }
}

class LoginResult {
  final String token;
  final String userId;
  final String role;
  final String email;
  final String name;

  LoginResult({
    required this.token,
    required this.userId,
    required this.role,
    required this.email,
    required this.name,
  });
}