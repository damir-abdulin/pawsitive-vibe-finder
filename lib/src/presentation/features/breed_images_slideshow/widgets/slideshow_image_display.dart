import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Widget for displaying the main image in the slideshow with zoom, pan, and swipe functionality.
///
/// This widget implements AC-2 and AC-5 from User Story 2:
/// - Supports swipe navigation (left/right)
/// - Pinch-to-zoom and pan gestures
/// - Disables swipe navigation when zoomed
class SlideshowImageDisplay extends StatefulWidget {
  /// The URL of the image to display.
  final String imageUrl;

  /// Whether the image is currently zoomed.
  final bool isZoomed;

  /// Callback for when zoom state changes.
  final ValueChanged<bool> onZoomChanged;

  /// Callback for left swipe (next image).
  final VoidCallback onSwipeLeft;

  /// Callback for right swipe (previous image).
  final VoidCallback onSwipeRight;

  /// Creates an instance of [SlideshowImageDisplay].
  const SlideshowImageDisplay({
    required this.imageUrl,
    required this.isZoomed,
    required this.onZoomChanged,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    super.key,
  });

  @override
  State<SlideshowImageDisplay> createState() => _SlideshowImageDisplayState();
}

class _SlideshowImageDisplayState extends State<SlideshowImageDisplay> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Only enable horizontal swipe when not zoomed (AC-5)
      onHorizontalDragEnd: widget.isZoomed ? null : _handleSwipe,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 1.0,
          maxScale: 4.0,
          onInteractionUpdate: _handleInteractionUpdate,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.contain,
              placeholder: (BuildContext context, String url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.error_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Oops! This image seems to have run off.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handles swipe gestures for navigation.
  void _handleSwipe(DragEndDetails details) {
    const double swipeThreshold = 100.0;

    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! > swipeThreshold) {
      // Swipe right = previous image
      widget.onSwipeRight();
    } else if (details.primaryVelocity! < -swipeThreshold) {
      // Swipe left = next image
      widget.onSwipeLeft();
    }
  }

  /// Handles zoom state changes.
  void _handleInteractionUpdate(ScaleUpdateDetails details) {
    final Matrix4 matrix = _transformationController.value;
    final double scale = matrix.getMaxScaleOnAxis();
    final bool isCurrentlyZoomed =
        scale > 1.1; // Small threshold to avoid floating point issues

    if (isCurrentlyZoomed != widget.isZoomed) {
      widget.onZoomChanged(isCurrentlyZoomed);
    }
  }
}
