import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/network_exceptions.dart';
import '../../../profile/data/models/profile_data.dart';
import '../../data/models/login_request.dart';
import '../../domain/usecases/login_usecase.dart';

const String _profileDataKey = 'profileData';

class AuthState {
  final bool isLoading;
  final ProfileData? profileData;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.profileData,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    ProfileData? profileData,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      profileData: profileData ?? this.profileData,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage storage;

  AuthNotifier({
    required this.loginUseCase,
    required this.storage,
    // Start in a loading state to show splash screen on app launch
  }) : super(AuthState(isLoading: true)) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profileJson = await storage.read(key: _profileDataKey);
      if (profileJson != null) {
        final profileData = ProfileData.fromJson(jsonDecode(profileJson));
        state = state.copyWith(isLoading: false, profileData: profileData);
      } else {
        // No profile found, no longer loading
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      // Handle potential errors during storage read/decode
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final loginResponse = await loginUseCase(
        LoginRequest(email: email, password: password),
      );

      final profileData = loginResponse.data;

      await storage.write(
        key: _profileDataKey,
        value: jsonEncode(profileData.toJson()),
      );
      debugPrint("AuthNotifier: Profile data saved. Preparing to update state.");
      state = state.copyWith(isLoading: false, profileData: profileData);
      debugPrint("AuthNotifier: State updated. New profileData name: \${state.profileData?.user.name}");

    } on NetworkException catch (e) {
      debugPrint("AuthNotifier: NetworkException caught: ${e.message}");
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      debugPrint("AuthNotifier: General exception caught: $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await storage.delete(key: _profileDataKey);
    state = AuthState();
  }
}
