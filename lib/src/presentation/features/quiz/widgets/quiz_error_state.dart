import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Error state widget for the quiz screen.
class QuizErrorState extends StatelessWidget {
  /// Creates a [QuizErrorState].
  const QuizErrorState({this.errorMessage, this.onRetry, super.key});

  /// The error message to display. If null, uses default message.
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
            const Icon(Icons.wifi_off, color: AppColors.error, size: 64),
            const SizedBox(height: 16),
            // Error message
            Text(
              errorMessage ?? 'Unable to load quiz questions',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
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
