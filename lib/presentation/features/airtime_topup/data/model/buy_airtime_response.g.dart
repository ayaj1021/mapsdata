// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_airtime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirtimeResponse _$AirtimeResponseFromJson(Map<String, dynamic> json) =>
    AirtimeResponse(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AirtimeResponseToJson(AirtimeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
    };
