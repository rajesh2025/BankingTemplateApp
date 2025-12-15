import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _installFlagKey = 'app_installed';

class AppInitializer {
  static Future<void> initialize() async {
    // Only iOS has this issue
    if (!Platform.isIOS) return;

    final prefs = await SharedPreferences.getInstance();
    final secureStorage = const FlutterSecureStorage();

    final isInstalled = prefs.getBool(_installFlagKey) ?? false;

    if (!isInstalled) {
      // 🚨 Fresh install detected → clear Keychain
      await secureStorage.deleteAll();

      // Mark app as installed
      await prefs.setBool(_installFlagKey, true);
    }
  }
}