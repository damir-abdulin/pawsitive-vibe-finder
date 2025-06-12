import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Error state widget for the favorites screen.
class FavoritesErrorState extends StatelessWidget {
  /// Creates a [FavoritesErrorState].
  const FavoritesErrorState({this.message, this.onRetry, super.key});

  /// The error message to display.
  final String? message;

  /// Callback when retry button is tapped.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Error icon
            const Icon(Icons.error_outline, color: AppColors.error, size: 64),
            const SizedBox(height: 16),
            // Error message
            Text(
              message ?? 'Failed to load favorites',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1B0E0E),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please try again later.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF756B6B), fontSize: 14),
            ),
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 24),
              // Retry button
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
