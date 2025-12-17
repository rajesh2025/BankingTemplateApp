// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileAction _$ProfileActionFromJson(Map<String, dynamic> json) =>
    ProfileAction(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      target: json['target'] as String,
    );

Map<String, dynamic> _$ProfileActionToJson(ProfileAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'target': instance.target,
    };
