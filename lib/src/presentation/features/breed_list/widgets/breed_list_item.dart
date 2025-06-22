import 'package:flutter/material.dart';
import '../../../../domain/models/breed_type.dart';

import '../../../utils/breed_type_localization.dart';

/// A single breed item in the breed list.
class BreedListItem extends StatefulWidget {
  /// Creates a [BreedListItem].
  const BreedListItem({required this.breed, required this.onTap, super.key});

  /// The breed to display.
  final BreedType breed;

  /// Callback when the item is tapped.
  final VoidCallback onTap;

  @override
  State<BreedListItem> createState() => _BreedListItemState();
}

class _BreedListItemState extends State<BreedListItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _getBackgroundColor(colorScheme),
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: <Widget>[
                // Breed name
                Expanded(
                  child: Text(
                    widget.breed.toLocal(context),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Chevron right icon
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (_isPressed) {
      return colorScheme.surfaceContainerHighest;
    } else if (_isHovered) {
      return colorScheme.surfaceContainerHigh;
    } else {
      return colorScheme.surface;
    }
  }
}
