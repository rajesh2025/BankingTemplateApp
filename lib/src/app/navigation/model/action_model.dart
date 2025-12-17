import 'package:json_annotation/json_annotation.dart';

part 'action_model.g.dart';

@JsonSerializable()
class AppAction {
  final String type;   // internal / external
  final String? target; // logout, profile, promo_details, etc.
  final String? url;
  final String? openIn;
  final Map<String, dynamic>? payload;

  AppAction({
    required this.type,
    this.target,
    this.url,
    this.openIn,
    this.payload,
  });

  factory AppAction.fromJson(Map<String, dynamic> json) =>
      _$AppActionFromJson(json);
}