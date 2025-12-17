// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  id: (json['id'] as num).toInt(),
  customerId: json['customerId'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  kycStatus: json['kycStatus'] as String,
  accountStatus: json['accountStatus'] as String,
  joinedOn: json['joinedOn'] as String,
  lastLoginAt: json['lastLoginAt'] as String,
  profileImageUrl: json['profileImageUrl'] as String,
  preferredLanguage: json['preferredLanguage'] as String,
  communicationPreferences: CommunicationPreferences.fromJson(
    json['communicationPreferences'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileImageUrl': instance.profileImageUrl,
      'kycStatus': instance.kycStatus,
      'accountStatus': instance.accountStatus,
      'joinedOn': instance.joinedOn,
      'lastLoginAt': instance.lastLoginAt,
      'preferredLanguage': instance.preferredLanguage,
      'communicationPreferences': instance.communicationPreferences,
    };

CommunicationPreferences _$CommunicationPreferencesFromJson(
  Map<String, dynamic> json,
) => CommunicationPreferences(
  email: json['email'] as bool,
  sms: json['sms'] as bool,
  push: json['push'] as bool,
);

Map<String, dynamic> _$CommunicationPreferencesToJson(
  CommunicationPreferences instance,
) => <String, dynamic>{
  'email': instance.email,
  'sms': instance.sms,
  'push': instance.push,
};
