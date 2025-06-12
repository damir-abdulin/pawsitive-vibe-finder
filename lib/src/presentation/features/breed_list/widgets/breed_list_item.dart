import 'package:flutter/material.dart';
import '../../../../domain/models/breed_type.dart';
import '../../../theme/colors.dart';
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
            color: _getBackgroundColor(),
            border: const Border(
              bottom: BorderSide(color: AppColors.dividerColor, width: 1),
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
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Chevron right icon
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_isPressed) {
      return AppColors.activeBackground;
    } else if (_isHovered) {
      return AppColors.hoverBackground;
    } else {
      return AppColors.primaryBackground;
    }
  }
}
