import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Empty state widget for the favorites screen.
class FavoritesEmptyState extends StatelessWidget {
  /// Creates a [FavoritesEmptyState].
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: const Color(0xFFF3E7E8), width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xFF756B6B),
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            const Text(
              'No favorite woofers yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1B0E0E),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            const Text(
              'Swipe right on an image you like to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF756B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Action hint
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFCF8F8),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFFF3E7E8), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.swipe, color: Color(0xFFE92933), size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Swipe right to favorite',
                    style: TextStyle(
                      color: Color(0xFF1B0E0E),
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
