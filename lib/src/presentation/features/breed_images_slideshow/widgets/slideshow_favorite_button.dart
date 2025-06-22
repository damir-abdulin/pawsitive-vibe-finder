import 'package:flutter/material.dart';

/// Widget for the favorite toggle button in the slideshow.
///
/// This widget implements AC-3 from User Story 2:
/// - Heart icon that fills/unfills based on favorite status
/// - Smooth animation when toggling
/// - Accessible button with clear visual states
class SlideshowFavoriteButton extends StatefulWidget {
  /// Whether the current image is marked as favorite.
  final bool isFavorite;

  /// Callback for when the favorite button is pressed.
  final VoidCallback onPressed;

  /// Creates an instance of [SlideshowFavoriteButton].
  const SlideshowFavoriteButton({
    required this.isFavorite,
    required this.onPressed,
    super.key,
  });

  @override
  State<SlideshowFavoriteButton> createState() =>
      _SlideshowFavoriteButtonState();
}

class _SlideshowFavoriteButtonState extends State<SlideshowFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.isFavorite ? 'Remove from favorites' : 'Add to favorites',
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        onTap: () {
          widget.onPressed();
          // Play a brief animation on tap
          _animationController.forward().then((_) {
            _animationController.reverse();
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorite
                          ? Colors.red
                          : Colors.grey.shade600,
                      size: 28,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            AnimatedOpacity(
              opacity: widget.isFavorite ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                'Liked',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.isFavorite ? Colors.red : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
