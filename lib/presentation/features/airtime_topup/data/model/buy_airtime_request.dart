import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buy_airtime_request.g.dart';

@JsonSerializable(createFactory: false)
class BuyAirtimeRequest implements EquatableMixin {
  const BuyAirtimeRequest({
    required this.id,
    required this.pin,
    required this.number,
    required this.amount,
  });

  final String id;
  final String pin;
  final String number;
  final String amount;

  Map<String, dynamic> toJson() => _$BuyAirtimeRequestToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object> get props => [id, pin, number];

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => true;
}
