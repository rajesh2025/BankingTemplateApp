// home_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'carousel_card.dart';
import 'image_card.dart';
import 'link_card.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  final String status;
  final String updatedAt;
  final HomeData data;

  HomeResponse({required this.status, required this.updatedAt, required this.data});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class HomeData {
  final List<CarouselCard> carousel;
  final List<ImageCard> imageCards;
  final LinkCard linkCard;

  HomeData({
    required this.carousel,
    required this.imageCards,
    required this.linkCard,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}