import 'package:json_annotation/json_annotation.dart';

import '../../../../app/navigation/model/action_model.dart';

part 'image_card.g.dart';

@JsonSerializable()
class ImageCard {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String? visualWeight; // square | medium | tall
  final String? a11yLabel;
  final AppAction action;

  ImageCard({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
    this.visualWeight,
    this.a11yLabel,
    required this.action,
  });

  factory ImageCard.fromJson(Map<String, dynamic> json)
  => _$ImageCardFromJson(json);
}