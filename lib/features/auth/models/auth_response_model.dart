class AuthResponse {
  final String username;
  final String access;
  final String refresh;

  AuthResponse({required this.username, required this.access, required this.refresh});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    username: json['username'],
    access: json['access'],
    refresh: json['refresh'],
  );


  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'access': access,
      'refresh': refresh,
    };
  }
}
