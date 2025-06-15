import 'package:equatable/equatable.dart';

import 'breed_image_model.dart';
import 'breed_type.dart';

/// Represents a collection of images for a specific dog breed.
///
/// This model encapsulates all images for a breed along with metadata
/// needed for the slideshow functionality, caching, and offline support.
class BreedImagesModel extends Equatable {
  /// The breed this collection belongs to.
  final BreedType breed;

  /// The list of images for this breed.
  final List<BreedImageModel> images;

  /// The total number of images in the collection.
  int get totalCount => images.length;

  /// Whether this collection has any images.
  bool get hasImages => images.isNotEmpty;

  /// Whether all images in this collection are cached.
  bool get isFullyCached =>
      images.every((BreedImageModel image) => image.isCached);

  /// The number of cached images in this collection.
  int get cachedCount =>
      images.where((BreedImageModel image) => image.isCached).length;

  /// The number of favorite images in this collection.
  int get favoriteCount =>
      images.where((BreedImageModel image) => image.isFavorite).length;

  /// Creates an instance of [BreedImagesModel].
  const BreedImagesModel({required this.breed, required this.images});

  /// Creates an empty collection for a breed.
  const BreedImagesModel.empty({required this.breed})
    : images = const <BreedImageModel>[];

  /// Creates a copy of this model with updated values.
  BreedImagesModel copyWith({BreedType? breed, List<BreedImageModel>? images}) {
    return BreedImagesModel(
      breed: breed ?? this.breed,
      images: images ?? this.images,
    );
  }

  /// Updates a specific image in the collection.
  BreedImagesModel updateImage(int index, BreedImageModel updatedImage) {
    final List<BreedImageModel> updatedImages = List<BreedImageModel>.from(
      images,
    );
    if (index >= 0 && index < updatedImages.length) {
      updatedImages[index] = updatedImage;
    }
    return copyWith(images: updatedImages);
  }

  /// Toggles the favorite status of an image at the given index.
  BreedImagesModel toggleFavorite(int index) {
    if (index >= 0 && index < images.length) {
      final BreedImageModel updatedImage = images[index].copyWith(
        isFavorite: !images[index].isFavorite,
      );
      return updateImage(index, updatedImage);
    }
    return this;
  }

  /// Marks an image as cached at the given index.
  BreedImagesModel markAsCached(int index) {
    if (index >= 0 && index < images.length && !images[index].isCached) {
      final BreedImageModel updatedImage = images[index].copyWith(
        isCached: true,
      );
      return updateImage(index, updatedImage);
    }
    return this;
  }

  @override
  List<Object> get props => <Object>[breed, images];
}
