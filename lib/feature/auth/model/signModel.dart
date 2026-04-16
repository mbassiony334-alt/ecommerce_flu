import 'package:e_commarcae/feature/user/model/userModel.dart';

class SignModel {
  final String message;
  final String token;
  final User user;

  SignModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignModel.fromJson(Map<String, dynamic> json) {
    return SignModel(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

}