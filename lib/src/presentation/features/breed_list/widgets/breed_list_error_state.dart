import 'package:flutter/material.dart';
import '../../../localization/locale_extension.dart';
import '../../../theme/colors.dart';

/// Error state widget for the breed list screen.
class BreedListErrorState extends StatelessWidget {
  /// Creates a [BreedListErrorState].
  const BreedListErrorState({this.errorMessage, this.onRetry, super.key});

  /// The error message to display. If null, uses default localized message.
  final String? errorMessage;

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
              errorMessage ?? context.locale.breedListFailedToLoad,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
