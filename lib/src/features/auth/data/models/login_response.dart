import 'package:json_annotation/json_annotation.dart';
import '../../../profile/data/models/profile_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String status;
  final String updatedAt;
  final ProfileData data;

  const LoginResponse({
    required this.status,
    required this.updatedAt,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      updatedAt: json['updatedAt'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}