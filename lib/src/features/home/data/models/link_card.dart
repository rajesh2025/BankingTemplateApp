import 'package:json_annotation/json_annotation.dart';

import '../../../../app/navigation/model/action_model.dart';

part 'link_card.g.dart';

@JsonSerializable()
class LinkCard {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? a11yHint;
  final AppAction action;

  LinkCard({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.a11yHint,
    required this.action,
  });

  factory LinkCard.fromJson(Map<String, dynamic> json) =>
      _$LinkCardFromJson(json);
  Map<String, dynamic> toJson() => _$LinkCardToJson(this);
}