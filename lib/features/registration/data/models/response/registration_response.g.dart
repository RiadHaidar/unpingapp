// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      message: json['message'] as String,
      data: RegistrationData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };

RegistrationData _$RegistrationDataFromJson(Map<String, dynamic> json) =>
    RegistrationData(
      token: json['token'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$RegistrationDataToJson(RegistrationData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
    };

RegistrationErrorResponse _$RegistrationErrorResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationErrorResponse(
      message: json['message'] as String,
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$RegistrationErrorResponseToJson(
        RegistrationErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };
