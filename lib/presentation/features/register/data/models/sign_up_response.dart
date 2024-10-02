// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

// @JsonSerializable(createToJson: false)
// class SignUpResponse extends AuthResponse {
//   const SignUpResponse({
//      super.tokens,
//     required super.code,
//     required super.status,
//     required super.message,
//   });

//   factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
//       _$SignUpResponseFromJson(json);
// }

// @JsonSerializable()
// class DSUser extends Equatable {
//   @JsonKey(defaultValue: '')
//   final int code;
//   @JsonKey(defaultValue: '')
//   final String status;
//   @JsonKey(defaultValue: '')
//   final String message;

//   const DSUser({
//     required this.code,
//     required this.status,
//     required this.message,
//   });

//   factory DSUser.fromJson(Map<String, dynamic> json) => _$DSUserFromJson(json);

//   Map<String, dynamic> toJson() => _$DSUserToJson(this);

//   @override
//   List<Object> get props => [code, status, message];
// }


@JsonSerializable()
class SignUpResponse {
    final int? code;
    final String? status;
    final String? message;

    SignUpResponse({
        this.code,
        this.status,
        this.message,
    });

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);

    Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
