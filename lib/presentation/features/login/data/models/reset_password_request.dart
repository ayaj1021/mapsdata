import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordRequest implements EquatableMixin {
  const ResetPasswordRequest({
    required this.password,
    required this.confirmPassword,
    required this.resetToken,
  });

  final String password;
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;
  @JsonKey(name: 'reset_token')
  final String resetToken;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [password, confirmPassword, resetToken];

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => true;
}
