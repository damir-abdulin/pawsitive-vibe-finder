import 'package:flutter/material.dart';
import '../../../localization/locale_extension.dart';
import '../../../theme/colors.dart';

/// Empty state widget for the breed list screen.
class BreedListEmptyState extends StatelessWidget {
  /// Creates a [BreedListEmptyState].
  const BreedListEmptyState({this.message, super.key});

  /// Custom message to display. If null, uses default localized message.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icon
            const Icon(Icons.pets, color: AppColors.textSecondary, size: 64),
            const SizedBox(height: 16),
            // Message
            Text(
              message ?? context.locale.breedListNoBreedsFound,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
