// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  token: json['token'] as String,
  user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
  security: SecurityInfo.fromJson(json['security'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'security': instance.security,
    };
