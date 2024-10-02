// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataPlansResponse _$GetDataPlansResponseFromJson(
        Map<String, dynamic> json) =>
    GetDataPlansResponse(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PlansData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDataPlansResponseToJson(
        GetDataPlansResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PlansData _$PlansDataFromJson(Map<String, dynamic> json) => PlansData(
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlansDataToJson(PlansData instance) => <String, dynamic>{
      'plans': instance.plans,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: json['id'] as String?,
      network: json['network'] as String?,
      plan: json['plan'] as String?,
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'network': instance.network,
      'plan': instance.plan,
      'type': instance.type,
      'amount': instance.amount,
    };
