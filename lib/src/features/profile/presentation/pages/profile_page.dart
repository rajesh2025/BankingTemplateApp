import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/navigation/action_router.dart';
import '../../../../app/navigation/model/action_model.dart';
import '../../data/models/profile_data.dart';
import '../../data/models/security_info.dart';
import '../../data/models/user_profile.dart';
import '../controllers/profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) => profile == null
            ? const Center(child: Text('Please login to see your profile.'))
            : _ProfileContent(
                profile: profile,
                onLogout: _confirmLogout,
              ),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must choose
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text(
            'Are you sure you want to logout?\n\nYou will need to login again to access the app.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (shouldLogout == true) {
      await _logout();
    }
  }

  Future<void> _logout() async {
    ActionRouter.handle(
      context,
      AppAction(type: 'internal', target: 'logout'),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final ProfileData profile;
  final VoidCallback onLogout;

  const _ProfileContent({
    required this.profile,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final user = profile.user;
    final security = profile.security;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ProfileHeader(user: user),
        const SizedBox(height: 16),
        _StatusCard(user: user),
        const SizedBox(height: 16),
        _SecurityCard(security: security),
        const SizedBox(height: 16),
        Card(
          color: Theme.of(context).colorScheme.errorContainer,
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: onLogout,
            textColor: Theme.of(context).colorScheme.onErrorContainer,
            iconColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserProfile user;

  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: user.profileImageUrl.isNotEmpty
                  ? NetworkImage(user.profileImageUrl)
                  : null,
              child: user.profileImageUrl.isNotEmpty
                  ? null
                  : Text(user.name[0]),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: Theme.of(context).textTheme.titleMedium),
                Text(user.email, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  'Customer ID: ${user.customerId}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final UserProfile user;
  const _StatusCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.verified_user),
        title: const Text('Account Status'),
        subtitle: Text(
          'KYC: ${user.kycStatus}\n'
          'Account: ${user.accountStatus}\n'
          'Security: Standard',
        ),
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  final SecurityInfo security;

  const _SecurityCard({required this.security});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.security),
        title: const Text('Security'),
        subtitle: Text(
          '2FA: ${security.twoFactorEnabled ? "Enabled" : "Disabled"}\n'
          'Last password change: ${security.lastPasswordChange}',
        ),
      ),
    );
  }
}
