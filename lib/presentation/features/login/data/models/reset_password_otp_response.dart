import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_otp_response.g.dart';

@JsonSerializable(createToJson: false)
class VerifyResetPasswordOtpResponse extends Equatable {
  const VerifyResetPasswordOtpResponse({
    required this.resetToken,
  });

  factory VerifyResetPasswordOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetPasswordOtpResponseFromJson(json);

  final String resetToken;

  @override
  List<Object?> get props => [resetToken];
}
