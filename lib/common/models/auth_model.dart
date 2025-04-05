import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final User user;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String phoneNumber;
  final String username;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String email;
  final String language;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.phoneNumber,
    required this.username,
    required this.email,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
