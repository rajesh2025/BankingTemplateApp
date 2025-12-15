// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselCard _$CarouselCardFromJson(Map<String, dynamic> json) => CarouselCard(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  imageUrl: json['imageUrl'] as String?,
  cta: json['cta'] as String?,
  importance: json['importance'] as String?,
  a11yLabel: json['a11yLabel'] as String?,
  action: AppAction.fromJson(json['action'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CarouselCardToJson(CarouselCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'cta': instance.cta,
      'importance': instance.importance,
      'a11yLabel': instance.a11yLabel,
      'action': instance.action,
    };
