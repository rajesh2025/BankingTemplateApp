// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkCard _$LinkCardFromJson(Map<String, dynamic> json) => LinkCard(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  a11yHint: json['a11yHint'] as String?,
  action: AppAction.fromJson(json['action'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LinkCardToJson(LinkCard instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'a11yHint': instance.a11yHint,
  'action': instance.action,
};
