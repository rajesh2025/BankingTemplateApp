// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/models/carousel_card.dart';
import '../../data/models/home_response.dart';
import '../../data/models/image_card.dart';
import '../controllers/auth_session_provider.dart';
import '../controllers/home_controller.dart';
import '../navigation/action_router.dart';
import 'login_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<_HomeMenuAction>(
            onSelected: (action) {
              switch (action) {
                case _HomeMenuAction.profile:
                  _openProfile(context);
                  break;
                case _HomeMenuAction.logout:
                  _confirmLogout(context, ref);
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _HomeMenuAction.profile,
                child: Text('Profile'),
              ),
              PopupMenuItem(
                value: _HomeMenuAction.logout,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: state.when(
        data: (home) => _buildContent(context, home, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildCarouselItem(
    BuildContext parentContext,
    CarouselCard cCard,
    bool isFirst,
  ) {
    return Builder(
      builder: (focusContext) {
        final isFocused = Focus.of(focusContext).hasFocus;

        return Padding(
          padding: EdgeInsets.only(left: isFirst ? 0 : 6, right: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (cCard.imageUrl != null)
                  Image.network(cCard.imageUrl!, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: isFocused
                          ? Border.all(
                              color: Theme.of(
                                parentContext,
                              ).colorScheme.primary,
                              width: 2,
                            )
                          : null,
                      color: Theme.of(
                        parentContext,
                      ).colorScheme.surface.withValues(alpha: 0.95),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          cCard.title,
                          style: Theme.of(parentContext).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (cCard.subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              cCard.subtitle!,
                              style: Theme.of(
                                parentContext,
                              ).textTheme.bodySmall,
                            ),
                          ),
                        if (cCard.cta != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              cCard.cta!,
                              style: TextStyle(
                                color: Theme.of(
                                  parentContext,
                                ).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeResponse home, WidgetRef ref) {
    final carousel = home.data.carousel;
    final imageCards = home.data.imageCards;
    final linkCard = home.data.linkCard;
    final width = MediaQuery.of(context).size.width;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final columns = width > 900
        ? 4
        : width > 600
        ? 3
        : 2;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(homeStateProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Column(
                children: [
                  // Carousel
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      padEnds: false,
                      itemCount: carousel.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final c = carousel[index];
                        return Semantics(
                          label:
                              c.a11yLabel ?? '${c.title}. ${c.subtitle ?? ''}',
                          button: true,
                          child: FocusableActionDetector(
                            autofocus: index == 0,
                            shortcuts: const {
                              SingleActivator(LogicalKeyboardKey.enter):
                                  ActivateIntent(),
                              SingleActivator(LogicalKeyboardKey.space):
                                  ActivateIntent(),
                            },
                            actions: {
                              ActivateIntent: CallbackAction<ActivateIntent>(
                                onInvoke: (_) {
                                  ActionRouter.handle(context, c.action);
                                  return null;
                                },
                              ),
                            },
                            child: InkWell(
                              onTap: () {
                                ActionRouter.handle(context, c.action);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: _buildCarouselItem(context, c, index == 0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //indicator
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      carousel.length,
                      (index) => AnimatedContainer(
                        duration: reduceMotion
                            ? Duration.zero
                            : const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 10 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.black87
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Image cards (grid)
                  MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: columns,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    itemCount: imageCards.length,
                    itemBuilder: (context, idx) {
                      final card = imageCards[idx];
                      return _ImageCard(card: card);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // External link card
            Semantics(
              button: true,
              hint: linkCard.a11yHint ?? 'Opens TrustINBank terms in webview',
              child: Card(
                child: ListTile(
                  leading: linkCard.imageUrl != null
                      ? Image.network(
                          linkCard.imageUrl!,
                          width: 56,
                          fit: BoxFit.cover,
                        )
                      : null,
                  title: Text(linkCard.title),
                  subtitle: linkCard.description != null
                      ? Text(linkCard.description!)
                      : null,
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    ActionRouter.handle(context, linkCard.action);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
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

    // ✅ Guard against disposed widget
    if (!mounted) return;

    if (shouldLogout == true) {
      await _logout(ref);
    }
  }

  Future<void> _logout(WidgetRef ref) async {
    final storage = ref.read(secureStorageProvider);

    // 1️⃣ Clear secure token
    await storage.delete(key: authTokenKey);

    // 2️⃣ Navigate to Login & clear back stack
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _openProfile(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile coming soon')));
  }
}

class _ImageCard extends StatelessWidget {
  final ImageCard card;

  const _ImageCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: card.a11yLabel ?? card.title,
      button: true,
      child: FocusableActionDetector(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _handleTap(context);
              return null;
            },
          ),
        },
        child: Builder(
          builder: (context) {
            final isFocused = Focus.of(context).hasFocus;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isFocused
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    : BorderSide.none,
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _handleTap(context),
                child: _buildCardContent(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    ActionRouter.handle(context, card.action);
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: _aspectRatioFromWeight(card.visualWeight),
          child: Image.network(
            card.imageUrl,
            fit: BoxFit.cover,
            semanticLabel: card.a11yLabel,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            card.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (card.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              card.description!,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  double _aspectRatioFromWeight(String? weight) {
    switch (weight) {
      case 'tall':
        return 4 / 5;
      case 'medium':
        return 3 / 4;
      default:
        return 1.0;
    }
  }
}

enum _HomeMenuAction { profile, logout }
