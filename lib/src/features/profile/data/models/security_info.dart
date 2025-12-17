import 'package:json_annotation/json_annotation.dart';

part 'security_info.g.dart';

@JsonSerializable()
class SecurityInfo {
  final bool twoFactorEnabled;
  final bool biometricEnabled;
  final String lastPasswordChange;
  final int trustedDevices;

  SecurityInfo({
    required this.twoFactorEnabled,
    required this.biometricEnabled,
    required this.lastPasswordChange,
    required this.trustedDevices,
  });

  factory SecurityInfo.fromJson(Map<String, dynamic> json) =>
      _$SecurityInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityInfoToJson(this);
}
