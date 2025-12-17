import 'package:json_annotation/json_annotation.dart';

part 'profile_action.g.dart';

@JsonSerializable()
class ProfileAction {
  final String id;
  final String title;
  final String type;
  final String target;

  const ProfileAction({
    required this.id,
    required this.title,
    required this.type,
    required this.target,
  });

  factory ProfileAction.fromJson(Map<String, dynamic> json) =>
      _$ProfileActionFromJson(json);
}