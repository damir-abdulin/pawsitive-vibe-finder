import 'package:flutter/material.dart';
import '../../../localization/locale_extension.dart';

/// Header widget for the breed list screen with title and search functionality.
class BreedListHeader extends StatelessWidget {
  /// Creates a [BreedListHeader].
  const BreedListHeader({
    required this.searchController,
    required this.onSearchChanged,
    super.key,
  });

  /// The search text controller.
  final TextEditingController searchController;

  /// Callback when search text changes.
  final VoidCallback onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: <Widget>[
          // Title section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                // Centered title
                Expanded(
                  child: Text(
                    context.locale.breedListTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Search section
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              controller: searchController,
              onChanged: (_) => onSearchChanged(),
              decoration: InputDecoration(
                hintText: context.locale.breedListSearchHint,
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                hintStyle: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
              style: TextStyle(color: colorScheme.onSurface, fontSize: 14),
            ),
          ),
          // Shadow separator
          Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
