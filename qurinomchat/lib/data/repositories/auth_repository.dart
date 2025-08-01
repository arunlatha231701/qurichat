import 'package:qurinomchat/core/constants/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qurinomchat/core/network/api_client.dart';
import 'package:qurinomchat/data/models/auth/login_request.dart';
import 'package:qurinomchat/data/models/auth/login_response.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiRoutes.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response.data);


      if (loginResponse.data.token.isEmpty ||
          loginResponse.data.user.id.isEmpty) {
        throw Exception('Invalid login response: Missing required fields');
      }
      print(loginResponse.data.toString()+"AAA");
      return loginResponse;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
  }
}