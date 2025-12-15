// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageCard _$ImageCardFromJson(Map<String, dynamic> json) => ImageCard(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String,
  visualWeight: json['visualWeight'] as String?,
  a11yLabel: json['a11yLabel'] as String?,
  action: AppAction.fromJson(json['action'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImageCardToJson(ImageCard instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'visualWeight': instance.visualWeight,
  'a11yLabel': instance.a11yLabel,
  'action': instance.action,
};
