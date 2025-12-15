import 'package:flutter/material.dart';
import '../../data/models/action_model.dart';
import '../pages/webview_page.dart';

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

  static void _handleInternal(
      BuildContext context,
      AppAction action,
      ) {
    switch (action.target) {
      case 'loan_page':
        _unsupported(context); // placeholder
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

      default:
        _unsupported(context);
    }
  }

  static void _handleExternal(
      BuildContext context,
      AppAction action,
      ) {
    if (action.url == null) return;

    if (action.openIn == 'webview') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewPage(
            url: action.url!,
            title: 'TrustINBank',
          ),
        ),
      );
    } else {
      _unsupported(context);
    }
  }

  static void _unsupported(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feature coming soon')),
    );
  }
}