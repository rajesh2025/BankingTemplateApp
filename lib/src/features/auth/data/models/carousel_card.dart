// carousel_card.dart
import 'package:json_annotation/json_annotation.dart';

import 'action_model.dart';

part 'carousel_card.g.dart';

@JsonSerializable()
class CarouselCard {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? cta;
  final String? importance;
  final String? a11yLabel;
  final AppAction action;

  CarouselCard({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.cta,
    this.importance,
    this.a11yLabel,
    required this.action,
  });

  factory CarouselCard.fromJson(Map<String, dynamic> json)
  => _$CarouselCardFromJson(json);
}