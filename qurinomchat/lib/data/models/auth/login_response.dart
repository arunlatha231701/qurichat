class LoginResponse {
  final bool encrypted;
  final LoginData data;

  LoginResponse({
    required this.encrypted,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      encrypted: json['encrypted'] as bool? ?? false,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class LoginData {
  final String token;
  final User user;

  LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class User {
  final String id;
  final String role;
  final String email;
  final String name;

  User({
    required this.id,
    required this.role,
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? 'User',
    );
  }
}