// auth_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../data/models/login_request.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthState {
  final bool loading;
  final String? token;
  final String? error;

  AuthState({this.loading = false, this.token, this.error});

  AuthState copyWith({bool? loading, String? token, String? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      token: token ?? this.token,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage storage;

  AuthNotifier({required this.loginUseCase, required this.storage}) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final resp = await loginUseCase(LoginRequest(email: email, password: password));
      // store token securely
      await storage.write(key: 'auth_token', value: resp.token);
      state = state.copyWith(loading: false, token: resp.token);
    } on NetworkException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}