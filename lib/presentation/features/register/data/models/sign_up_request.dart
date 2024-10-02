import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest extends Equatable {
  const SignUpRequest({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.number,
    required this.password,
    required this.confirmPassword,
  });

//   {
//     "firstname": "Femi",
//     "lastname": "Dayo",
//     "username": "Femo2",
//     "email": "ayaj102+0@gmail.com",
//     "number": "09123456789",
//     "password": "123456",
//     "confirm_password": "123456"
// }

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? number;

  final String? password;
  @JsonKey(name: 'confirm_password')
  final String? confirmPassword;

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

  SignUpRequest copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? number,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpRequest(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        username,
        email,
        number,
        password,
        confirmPassword,
      ];
}
