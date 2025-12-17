import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers/providers.dart';
import '../../data/models/profile_data.dart';

final profileProvider = Provider<AsyncValue<ProfileData?>>((ref) {
  final authState = ref.watch(authNotifierProvider);

  if (authState.isLoading) {
    return const AsyncValue.loading();
  }
  if (authState.error != null) {
    return AsyncValue.error(authState.error!, StackTrace.empty);
  }
  return AsyncValue.data(authState.profileData);
});
