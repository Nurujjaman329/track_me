class ProfileModel {
  final String username;
  final String email;

  ProfileModel({required this.username, required this.email});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      email: json['email'],
    );
  }
}
