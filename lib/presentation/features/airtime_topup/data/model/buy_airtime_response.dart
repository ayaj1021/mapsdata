import 'package:json_annotation/json_annotation.dart';
part 'buy_airtime_response.g.dart';
@JsonSerializable()
class AirtimeResponse {
  final int? code;
  final String? status;
  final String? message;

  AirtimeResponse({
    this.code,
    this.status,
    this.message,
  });

  factory AirtimeResponse.fromJson(Map<String, dynamic> json) =>
      _$AirtimeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AirtimeResponseToJson(this);
}
