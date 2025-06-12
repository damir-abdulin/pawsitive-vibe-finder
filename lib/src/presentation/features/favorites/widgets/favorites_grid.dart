import 'package:flutter/material.dart';
import '../../../../domain/models/dog_model.dart';
import 'favorite_image_grid_item.dart';

/// A responsive grid widget for displaying favorite dog images.
class FavoritesGrid extends StatelessWidget {
  /// Creates a [FavoritesGrid].
  const FavoritesGrid({
    required this.dogs,
    required this.unfavoritedInSession,
    required this.onFavoriteToggle,
    required this.onImageTap,
    super.key,
  });

  /// The list of favorite dogs to display.
  final List<DogModel> dogs;

  /// Set of dogs that have been unfavorited in the current session.
  final Set<String> unfavoritedInSession;

  /// Callback when a favorite toggle is performed.
  final void Function(DogModel dog, bool isFavorite) onFavoriteToggle;

  /// Callback when an image is tapped.
  final void Function(DogModel dog) onImageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: dogs.length,
        itemBuilder: (BuildContext context, int index) {
          final DogModel dog = dogs[index];
          final bool isFavorite = !unfavoritedInSession.contains(dog.imageUrl);

          return FavoriteImageGridItem(
            dog: dog,
            isFavorite: isFavorite,
            onFavoriteToggle: () => onFavoriteToggle(dog, isFavorite),
            onImageTap: () => onImageTap(dog),
          );
        },
      ),
    );
  }

  /// Determines the number of columns based on screen width.
  int _getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1024) {
      return 4; // Desktop: 4 columns
    } else if (screenWidth >= 768) {
      return 3; // Tablet: 3 columns
    } else {
      return 2; // Mobile: 2 columns
    }
  }
}
