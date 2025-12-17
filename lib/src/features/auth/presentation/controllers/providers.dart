import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_controller.dart';

// Reverted to the standard, platform-agnostic provider.
final secureStorageProvider = Provider((_) => const FlutterSecureStorage());

final baseUrlProvider =
    Provider<String>((_) => 'https://trustinbank.free.beeceptor.com');

final dioClientProvider = Provider((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return DioClient(baseUrl: baseUrl);
});

final authRemoteDataSourceProvider = Provider((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDataSource(dioClient: dioClient);
});

final authRepositoryProvider = Provider((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remote: remote);
});

final loginUseCaseProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUseCase(repo);
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthNotifier(loginUseCase: loginUseCase, storage: storage);
});
