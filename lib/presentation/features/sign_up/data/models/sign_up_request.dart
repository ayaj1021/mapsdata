import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest extends Equatable {
  const SignUpRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.username,
    required this.alipayQrCode,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  final String? email;

  final String? password;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? gender;

  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  final String? username;

  @JsonKey(name: 'alipay_qr_code')
  final String? alipayQrCode;

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

  SignUpRequest copyWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? gender,
    String? dateOfBirth,
    String? username,
    String? alipayQrCode,
  }) {
    return SignUpRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      username: username ?? this.username,
      alipayQrCode: alipayQrCode ?? this.alipayQrCode,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        gender,
        dateOfBirth,
        username,
        alipayQrCode,
      ];
}
