import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable(createToJson: false)
class ResetPasswordResponse extends Equatable {
  const ResetPasswordResponse({
    required this.message,
  
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  final String message;
 

  @override
  List<Object?> get props => [message];
}
