import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

/// Home image card widget that displays a dog image with swipe functionality.
class HomeImageCard extends StatelessWidget {
  /// Creates a [HomeImageCard].
  const HomeImageCard({
    required this.dog,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    super.key,
  });

  /// The dog to display.
  final DogModel dog;

  /// Callback when the card is swiped left.
  final VoidCallback onSwipeLeft;

  /// Callback when the card is swiped right.
  final VoidCallback onSwipeRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (DragEndDetails details) {
        final double velocity = details.velocity.pixelsPerSecond.dx;
        if (velocity > 300) {
          // Swipe right
          onSwipeRight();
        } else if (velocity < -300) {
          // Swipe left
          onSwipeLeft();
        }
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400),
        child: AspectRatio(
          aspectRatio: 3 / 4, // 3:4 aspect ratio from design
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: dog.imageUrl,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String url) => Container(
                  color: Theme.of(context).cardTheme.color,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (BuildContext context, String url, Object error) =>
                    Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
