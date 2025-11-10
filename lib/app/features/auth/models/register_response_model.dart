class RegisterResponseModel {
  final int id;
  final String username;
  final String email;

  RegisterResponseModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id']?? 0,
      username: json['username']?? '',
      email: json['email']?? '',
    );
  }
}
