import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Image widget for displaying the dog image in the quiz.
class QuizImage extends StatelessWidget {
  /// Creates a [QuizImage].
  const QuizImage({required this.imageUrl, super.key});

  /// The URL of the dog image to display.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.10),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (BuildContext context, String url) => Container(
              color: colorScheme.surfaceContainerHighest,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              ),
            ),
            errorWidget: (BuildContext context, String url, dynamic error) =>
                Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: colorScheme.error,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
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
}
