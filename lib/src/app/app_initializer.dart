import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _installFlagKey = 'hasRunBefore';

class AppInitializer {
  static Future<void> initialize() async {
    // This check must happen before any Platform-specific code.
    if (kIsWeb) return;

    // On iOS and macOS, keychain data can persist across app uninstalls.
    // This logic clears it on the first run to ensure a clean state.
    if (Platform.isIOS || Platform.isMacOS) {
      final prefs = await SharedPreferences.getInstance();
      final secureStorage = const FlutterSecureStorage();

      final hasRunBefore = prefs.getBool(_installFlagKey) ?? false;

      if (!hasRunBefore) {
        // 🚨 Fresh install detected → clear Keychain
        await secureStorage.deleteAll();

        // Mark app as having run before
        await prefs.setBool(_installFlagKey, true);
      }
    }
  }
}
