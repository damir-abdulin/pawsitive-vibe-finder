import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Loading widget for the breed list screen.
class BreedListLoading extends StatelessWidget {
  /// Creates a [BreedListLoading].
  const BreedListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }
}
