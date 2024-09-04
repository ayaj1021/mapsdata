import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable(createToJson: false)
class ForgotPasswordResponse extends Equatable {
  const ForgotPasswordResponse({
    required this.message,
    required this.otp,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  final String message;
  final String otp;

  @override
  List<Object?> get props => [message];
}
