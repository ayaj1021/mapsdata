import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest implements EquatableMixin {
  const LoginRequest({
    required this.password,
    required this.email,
  });

  final String password;
  final String email;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object> get props => [password, email];

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => true;
}
