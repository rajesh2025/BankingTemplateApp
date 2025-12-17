// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppAction _$AppActionFromJson(Map<String, dynamic> json) => AppAction(
  type: json['type'] as String,
  target: json['target'] as String?,
  url: json['url'] as String?,
  openIn: json['openIn'] as String?,
  payload: json['payload'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AppActionToJson(AppAction instance) => <String, dynamic>{
  'type': instance.type,
  'target': instance.target,
  'url': instance.url,
  'openIn': instance.openIn,
  'payload': instance.payload,
};
