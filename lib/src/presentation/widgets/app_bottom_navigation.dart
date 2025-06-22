import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../navigation/app_router.dart';

import '../localization/locale_extension.dart';

/// Bottom navigation bar for the application.
class AppBottomNavigation extends StatelessWidget {
  /// Creates an [AppBottomNavigation].
  const AppBottomNavigation({required this.currentRoute, super.key});

  /// The current route name.
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerTheme.color ?? Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                context: context,
                icon: Icons.home,
                label: context.locale.drawerHome,
                routeName: 'HomeRoute',
                onTap: () => context.router.navigate(HomeRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.list_alt,
                label: context.locale.drawerBreeds,
                routeName: 'BreedListRoute',
                onTap: () => context.router.navigate(const BreedListRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.favorite_border,
                label: context.locale.drawerFavorites,
                routeName: 'FavoritesRoute',
                onTap: () => context.router.navigate(const FavoritesRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.quiz,
                label: context.locale.drawerQuiz,
                routeName: 'QuizRoute',
                onTap: () => context.router.navigate(const QuizRoute()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String routeName,
    required VoidCallback onTap,
  }) {
    final bool isActive = currentRoute == routeName;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 28,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
