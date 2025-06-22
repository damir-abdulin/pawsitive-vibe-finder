import 'package:flutter/material.dart';

/// Empty state widget for the favorites screen.
class FavoritesEmptyState extends StatelessWidget {
  /// Creates a [FavoritesEmptyState].
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Empty favorites icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.08),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite_border,
                  color: colorScheme.onSurfaceVariant,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              'No favorite woofers yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Text(
              'Swipe right on an image you like to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Action hint
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.swipe, color: colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Swipe right to favorite',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
