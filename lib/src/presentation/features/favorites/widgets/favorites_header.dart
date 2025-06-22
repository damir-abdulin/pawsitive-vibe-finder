import 'package:flutter/material.dart';

/// Header widget for the favorites screen with back button and title.
class FavoritesHeader extends StatelessWidget {
  /// Creates a [FavoritesHeader].
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: const SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              // Centered title
              Expanded(child: _FavoritesHeaderTitle()),
              // Placeholder for balance (same width as back button)
              SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoritesHeaderTitle extends StatelessWidget {
  const _FavoritesHeaderTitle();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Text(
      'Favorites',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      ),
    );
  }
}
