import 'package:banking_template_app/src/features/auth/presentation/controllers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/models/home_request.dart';
import '../../data/models/home_response.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_usecase.dart';
import 'auth_controller.dart';
import 'auth_session_provider.dart';

final homeUseCaseProvider = Provider<GetHomeUseCase>((ref) {
  final repo = ref.watch(homeRepositoryProvider);
  return GetHomeUseCase(repository: repo);
});

final homeStateProvider = StateNotifierProvider<HomeNotifier, AsyncValue<HomeResponse>>((ref) {
  final usecase = ref.watch(homeUseCaseProvider);
  final storage = ref.watch(secureStorageProvider);
  return HomeNotifier(usecase: usecase, storage: storage);
});

// you'll need secureStorageProvider from your auth controller; if it's at a different path, import accordingly
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final remote = HomeRemoteDataSource(dioClient: dioClient);
  return HomeRepositoryImpl(remote: remote);
});

class HomeNotifier extends StateNotifier<AsyncValue<HomeResponse>> {
  final GetHomeUseCase usecase;
  final FlutterSecureStorage storage;
  HomeNotifier({required this.usecase, required this.storage}) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) {
        state = AsyncValue.error('No token found', StackTrace.empty);
        return;
      }
      final request = HomeRequest(token: token);
      final res = await usecase.call(request);
      state = AsyncValue.data(res);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _load();
  }
}