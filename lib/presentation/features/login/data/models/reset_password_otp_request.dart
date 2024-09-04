import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_otp_request.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordOtpRequest implements EquatableMixin {
  const ResetPasswordOtpRequest({
    required this.email,
    required this.otp,
  });

  final String email;
  final int otp;

  Map<String, dynamic> toJson() => _$ResetPasswordOtpRequestToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [email, otp];

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => true;
}
