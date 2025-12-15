import 'package:banking_template_app/src/app/app_initializer.dart';
import 'package:banking_template_app/src/common/splash_screen.dart';
import 'package:banking_template_app/src/features/auth/presentation/controllers/auth_session_provider.dart';
import 'package:banking_template_app/src/features/auth/presentation/pages/home_page.dart';
import 'package:banking_template_app/src/flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authSessionProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      title: 'Banking Template App',
      home: authState.when(
          data: (isLoggedIn) {
        if (isLoggedIn) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
          error: (_, _) => const LoginPage(),
          loading: () => const SplashScreen()),
    );
  }
}