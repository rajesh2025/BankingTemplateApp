import 'package:json_annotation/json_annotation.dart';

part 'home_request.g.dart';

@JsonSerializable()
class HomeRequest {
  final String token;

  HomeRequest({required this.token});

  Map<String, dynamic> toJson() => _$HomeRequestToJson(this);
}