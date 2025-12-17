import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widgets/webview_page.dart';
import '../../features/auth/presentation/controllers/providers.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'model/action_model.dart';

class ActionRouter {
  static void handle(BuildContext context, AppAction action) {
    switch (action.type) {
      case 'internal':
        _handleInternal(context, action);
        break;

      case 'external':
        _handleExternal(context, action);
        break;

      default:
        _unsupported(context);
    }
  }

  static void _handleInternal(BuildContext context, AppAction action) {
    switch (action.target) {
      case 'loan_page':
        _unsupported(context);
        break;

      case 'account_page':
        _unsupported(context);
        break;

      case 'promo_details':
        _unsupported(context);
        break;

      case 'security_tips':
        _unsupported(context);
        break;
      case 'logout':
        _handleLogout(context);
        break;
      case 'profile':
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;

      default:
        _unsupported(context);
    }
  }

  static void _handleExternal(BuildContext context, AppAction action) {
    if (action.url == null) return;

    if (action.openIn == 'webview') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewPage(url: action.url!, title: 'TrustINBank'),
        ),
      );
    } else {
      _unsupported(context);
    }
  }

  static void _unsupported(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  }

  static Future<void> _handleLogout(BuildContext context) async {
    // 1️⃣ Call the single source of truth to perform logout.
    // This is the centralized logic you wanted.
    await ProviderScope.containerOf(context)
        .read(authNotifierProvider.notifier)
        .logout();

    // 2️⃣ Navigate safely
    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }
}
