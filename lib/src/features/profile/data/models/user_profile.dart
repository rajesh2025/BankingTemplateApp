import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final int id;
  final String customerId;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String kycStatus;
  final String accountStatus;
  final String joinedOn;
  final String lastLoginAt;
  final String preferredLanguage;
  final CommunicationPreferences communicationPreferences;

  UserProfile({
    required this.id,
    required this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.kycStatus,
    required this.accountStatus,
    required this.joinedOn,
    required this.lastLoginAt,
    required this.profileImageUrl,
    required this.preferredLanguage,
    required this.communicationPreferences,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class CommunicationPreferences {
  final bool email;
  final bool sms;
  final bool push;

  CommunicationPreferences({
    required this.email,
    required this.sms,
    required this.push,
  });

  factory CommunicationPreferences.fromJson(Map<String, dynamic> json) =>
      _$CommunicationPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicationPreferencesToJson(this);
}
