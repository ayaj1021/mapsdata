import 'package:json_annotation/json_annotation.dart';
part 'get_data_response_model.g.dart';

@JsonSerializable()
class GetDataPlansResponse {
  final int? code;
  final String? status;
  final String? message;
  final PlansData? data;

  GetDataPlansResponse({this.code, this.status, this.message, this.data});

  factory GetDataPlansResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDataPlansResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataPlansResponseToJson(this);
}

@JsonSerializable()
class PlansData {
  final List<Plan>? plans;

  PlansData({this.plans});

  factory PlansData.fromJson(Map<String, dynamic> json) =>
      _$PlansDataFromJson(json);

  Map<String, dynamic> toJson() => _$PlansDataToJson(this);
}

@JsonSerializable()
class Plan {
  final String? id;
  final String? network;
  final String? plan;
  final String? type;
  final int? amount;

  Plan({this.id, this.network, this.plan, this.type, this.amount});

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
