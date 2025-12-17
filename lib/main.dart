import 'package:banking_template_app/src/features/auth/presentation/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app/app_initializer.dart';
import 'src/common/splash_screen.dart';
import 'src/features/auth/presentation/controllers/auth_controller.dart';
import 'src/features/auth/presentation/pages/login_page.dart';
import 'src/features/home/presentation/pages/home_page.dart';
import 'src/flutter/material.dart';

void main() async {
  // Ensure bindings are initialized for platform-specific code.
  WidgetsFlutterBinding.ensureInitialized();
  // Handle fresh install logic before running the app.
  await AppInitializer.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      title: 'Banking Template App',
      home: buildHome(authState),
    );
  }

  Widget buildHome(AuthState authState) {
    if (authState.isLoading) {
      return const SplashScreen();
    }

    if (authState.error != null) {
     // Optionally, show a dedicated error screen
      return const LoginPage();
    }

    if (authState.profileData != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
