import 'package:flutter/material.dart';

/// Widget for navigation buttons (Next/Previous) in the slideshow.
///
/// This widget implements AC-2 from User Story 2:
/// - Provides consistent styling for navigation buttons
/// - Supports disabled state when zoomed
/// - Includes accessibility tooltips
class SlideshowNavigationButton extends StatelessWidget {
  /// The icon to display in the button.
  final IconData icon;

  /// Callback for when the button is pressed.
  final VoidCallback? onPressed;

  /// Tooltip text for accessibility.
  final String tooltip;

  /// Creates an instance of [SlideshowNavigationButton].
  const SlideshowNavigationButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: onPressed != null
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          boxShadow: onPressed != null
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: onPressed != null ? Colors.white : Colors.grey.shade500,
          ),
          iconSize: 24,
        ),
      ),
    );
  }
}
