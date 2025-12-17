// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityInfo _$SecurityInfoFromJson(Map<String, dynamic> json) => SecurityInfo(
  twoFactorEnabled: json['twoFactorEnabled'] as bool,
  biometricEnabled: json['biometricEnabled'] as bool,
  lastPasswordChange: json['lastPasswordChange'] as String,
  trustedDevices: (json['trustedDevices'] as num).toInt(),
);

Map<String, dynamic> _$SecurityInfoToJson(SecurityInfo instance) =>
    <String, dynamic>{
      'twoFactorEnabled': instance.twoFactorEnabled,
      'biometricEnabled': instance.biometricEnabled,
      'lastPasswordChange': instance.lastPasswordChange,
      'trustedDevices': instance.trustedDevices,
    };
