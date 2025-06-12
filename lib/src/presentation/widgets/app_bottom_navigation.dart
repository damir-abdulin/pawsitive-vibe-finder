import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../navigation/app_router.dart';
import '../theme/colors.dart';

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
        color: AppColors.primaryBackground.withOpacity(0.9),
        border: const Border(
          top: BorderSide(color: AppColors.secondaryBackground, width: 1),
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
                label: 'Home',
                routeName: 'HomeRoute',
                onTap: () => context.router.navigate(HomeRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.list_alt,
                label: 'Breeds',
                routeName: 'BreedListRoute',
                onTap: () => context.router.navigate(const BreedListRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.favorite_border,
                label: 'Favorites',
                routeName: 'FavoritesRoute',
                onTap: () => context.router.navigate(const FavoritesRoute()),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.quiz,
                label: 'Quiz',
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
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
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
