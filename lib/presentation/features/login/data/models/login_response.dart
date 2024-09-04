
import 'package:json_annotation/json_annotation.dart';
import 'package:mapsdata/domain/models/auth_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends AuthResponse {
  const LoginResponse({
     super.tokens,
    required super.email,
    required super.firstName,
    required super.lastName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
