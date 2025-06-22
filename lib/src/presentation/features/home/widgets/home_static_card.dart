import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';

/// Static home image card widget for background cards in the stack.
class HomeStaticCard extends StatelessWidget {
  /// Creates a [HomeStaticCard].
  const HomeStaticCard({
    required this.dog,
    this.isBackground = false,
    super.key,
  });

  /// The dog to display.
  final DogModel dog;

  /// Whether this card is used as a background card.
  final bool isBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      child: AspectRatio(
        aspectRatio: 3 / 4, // 3:4 aspect ratio from design
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: isBackground
                    ? Colors.black.withValues(alpha: 0.08)
                    : Colors.black12,
                offset: const Offset(0, 4),
                blurRadius: isBackground ? 4 : 8,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              // Dog image with improved caching
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: dog.imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  memCacheWidth: 400, // Optimize memory usage
                  memCacheHeight: 533, // 400 * 4/3 for aspect ratio
                  placeholder: (BuildContext context, String url) => Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          Container(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.pets,
                                    size: 32,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Image unavailable',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                ),
              ),
              // Subtle overlay for background cards
              if (isBackground)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
