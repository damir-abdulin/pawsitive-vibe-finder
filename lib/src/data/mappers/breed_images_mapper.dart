import '../../domain/models/models.dart';
import '../entities/breed_images/breed_images_response_entity.dart';

/// A mapper class for converting between breed images entities and models.
class BreedImagesMapper {
  /// Converts a [BreedImagesResponseEntity] to a [BreedImagesModel].
  static BreedImagesModel toDomain({
    required BreedImagesResponseEntity entity,
    required BreedType breed,
  }) {
    final List<BreedImageModel> images = entity.message
        .map(
          (String imageUrl) => BreedImageModel(
            imageUrl: imageUrl,
            breed: breed,
            // Default values - favorites and cache status will be determined elsewhere
          ),
        )
        .toList();

    return BreedImagesModel(breed: breed, images: images);
  }

  /// Converts cached image URLs to a [BreedImagesModel].
  static BreedImagesModel fromCachedUrls({
    required List<String> imageUrls,
    required BreedType breed,
  }) {
    final List<BreedImageModel> images = imageUrls
        .map(
          (String imageUrl) => BreedImageModel(
            imageUrl: imageUrl,
            breed: breed,
            // isFavorite defaults to false - will be updated separately
            isCached: true, // These are cached images
          ),
        )
        .toList();

    return BreedImagesModel(breed: breed, images: images);
  }

  /// Extracts image URLs from a [BreedImagesModel] for caching.
  static List<String> extractImageUrls(BreedImagesModel model) {
    return model.images.map((BreedImageModel image) => image.imageUrl).toList();
  }

  /// Calculates estimated cache size for a list of image URLs.
  /// This is a rough estimate - actual implementation would need to download
  /// and measure actual image sizes.
  static int estimateCacheSizeBytes(List<String> imageUrls) {
    // Rough estimate: average dog image is about 200KB
    const int averageImageSizeBytes = 200 * 1024; // 200KB
    return imageUrls.length * averageImageSizeBytes;
  }
}
