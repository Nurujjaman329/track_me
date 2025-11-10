class LoginResponseModel {
  final String username;
  final String access;
  final String refresh;

  LoginResponseModel({
    required this.username,
    required this.access,
    required this.refresh,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      username: json['username']?? '',
      access: json['access']?? '',
      refresh: json['refresh']?? '',
    );
  }
}
