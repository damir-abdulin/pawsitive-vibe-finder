import 'package:flutter/material.dart';

/// Header widget for the favorites screen with back button and title.
class FavoritesHeader extends StatelessWidget {
  /// Creates a [FavoritesHeader].
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F8).withValues(alpha: 0.8),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 1),
        ],
      ),
      child: const SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              // Centered title
              Expanded(
                child: Text(
                  'Favorites',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1B0E0E),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.25,
                  ),
                ),
              ),
              // Placeholder for balance (same width as back button)
              SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}
