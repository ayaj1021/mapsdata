import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final int? code;
  final String? status;
  final String? message;
  final User? user;

  LoginResponse({
    this.code,
    this.status,
    this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class User {
  final String? token;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? username;
  @JsonKey(defaultValue: "phone_number")
  final String? phoneNumber;
  final String? apikey;
  final dynamic verification;

  User({
    this.token,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.phoneNumber,
    this.apikey,
    this.verification,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
