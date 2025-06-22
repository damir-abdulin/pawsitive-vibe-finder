import 'package:flutter/material.dart';

/// Loading widget for the breed list screen.
class BreedListLoading extends StatelessWidget {
  /// Creates a [BreedListLoading].
  const BreedListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
