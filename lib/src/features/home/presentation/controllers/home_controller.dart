import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers/providers.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/models/home_request.dart';
import '../../data/models/home_response.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_usecase.dart';

final homeUseCaseProvider = Provider<GetHomeUseCase>((ref) {
  final repo = ref.watch(homeRepositoryProvider);
  return GetHomeUseCase(repository: repo);
});

final homeStateProvider =
    StateNotifierProvider<HomeNotifier, AsyncValue<HomeResponse>>((ref) {
  final useCase = ref.watch(homeUseCaseProvider);
  // Reactively watch for the token from the single source of truth
  final token = ref.watch(authNotifierProvider.select((auth) => auth.profileData?.token));

  return HomeNotifier(useCase: useCase, token: token);
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final remote = HomeRemoteDataSource(dioClient: dioClient);
  return HomeRepositoryImpl(remote: remote);
});

class HomeNotifier extends StateNotifier<AsyncValue<HomeResponse>> {
  final GetHomeUseCase useCase;
  final String? token;

  HomeNotifier({required this.useCase, this.token})
      : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    // Uses the token passed in from the provider, which is sourced from AuthState
    if (token == null) {
      state = AsyncValue.error('Not authenticated', StackTrace.empty);
      return;
    }
    try {
      final request = HomeRequest(token: token!);
      final res = await useCase.call(request);
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
