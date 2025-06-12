import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Loading widget for the favorites screen.
class FavoritesLoading extends StatelessWidget {
  /// Creates a [FavoritesLoading].
  const FavoritesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: 16),
          Text(
            'Loading your favorites...',
            style: TextStyle(
              color: Color(0xFF756B6B),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
