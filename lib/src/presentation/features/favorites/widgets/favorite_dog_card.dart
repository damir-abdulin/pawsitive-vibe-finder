import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';

/// A card widget to display a single favorite dog in a grid.
///
/// This widget shows the dog's image and a heart icon to indicate its
/// favorite status. It provides a callback to handle favorite status changes.
class FavoriteDogCard extends StatelessWidget {
  /// The dog model to display.
  final DogModel dog;

  /// A flag indicating if the dog is currently marked as a favorite.
  final bool isFavorite;

  /// A callback function that is invoked when the heart icon is tapped.
  final VoidCallback onFavoritePressed;

  /// A callback function that is invoked when the card itself is tapped.
  final VoidCallback onCardTapped;

  /// Creates a [FavoriteDogCard] instance.
  const FavoriteDogCard({
    required this.dog,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onCardTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onCardTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: dog.imageUrl,
              child: CachedNetworkImage(
                imageUrl: dog.imageUrl,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (BuildContext context, String url, Object error) =>
                    const Icon(Icons.error),
              ),
            ),
            _buildFavoriteIcon(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteIcon(ThemeData theme) {
    final ColorScheme colorScheme = theme.colorScheme;
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? colorScheme.error : colorScheme.onSurfaceVariant,
        ),
        onPressed: onFavoritePressed,
      ),
    );
  }
}
