// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
  status: json['status'] as String,
  updatedAt: json['updatedAt'] as String,
  data: HomeData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'updatedAt': instance.updatedAt,
      'data': instance.data,
    };

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => HomeData(
  carousel: (json['carousel'] as List<dynamic>)
      .map((e) => CarouselCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  imageCards: (json['imageCards'] as List<dynamic>)
      .map((e) => ImageCard.fromJson(e as Map<String, dynamic>))
      .toList(),
  linkCard: LinkCard.fromJson(json['linkCard'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
  'carousel': instance.carousel,
  'imageCards': instance.imageCards,
  'linkCard': instance.linkCard,
};
