// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mapsdata/domain/models/auth_response.dart';

part 'sign_up_response.g.dart';

@JsonSerializable(createToJson: false)
class SignUpResponse extends AuthResponse {
  const SignUpResponse({
     super.tokens,
    required super.email,
    required super.firstName,
    required super.lastName,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}

@JsonSerializable()
class DSUser extends Equatable {
  @JsonKey(defaultValue: '')
  final String email;
  @JsonKey(defaultValue: '')
  final String firstName;
  @JsonKey(defaultValue: '')
  final String lastName;

  const DSUser({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory DSUser.fromJson(Map<String, dynamic> json) => _$DSUserFromJson(json);

  Map<String, dynamic> toJson() => _$DSUserToJson(this);

  @override
  List<Object> get props => [email, firstName, lastName];
}
