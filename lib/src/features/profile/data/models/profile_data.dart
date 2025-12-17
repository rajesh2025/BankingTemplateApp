import 'package:banking_template_app/src/features/profile/data/models/security_info.dart';
import 'package:banking_template_app/src/features/profile/data/models/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_data.g.dart';

@JsonSerializable()
class ProfileData {
  final String token;
  final UserProfile user;
  final SecurityInfo security;

  // final List<ProfileAction> actions;

  const ProfileData({
    required this.token,
    required this.user,
    required this.security,
    // required this.actions,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      token: json['token'],
      user: UserProfile.fromJson(json['user']),
      security: SecurityInfo.fromJson(json['security']),
    );
  }

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);

}