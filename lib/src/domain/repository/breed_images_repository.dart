import '../models/breed_images_model.dart';
import '../models/breed_type.dart';

/// An abstract interface for fetching and managing breed image collections.
///
/// This repository handles operations related to breed image galleries,
/// including fetching all images for a breed, caching support, and
/// offline capability as defined in User Story 2.
abstract class BreedImagesRepository {
  /// Fetches all images for a specific breed.
  ///
  /// The [breed] parameter specifies which breed's images to fetch.
  ///
  /// Returns a [Future] that completes with a [BreedImagesModel] containing
  /// all available images for the breed.
  ///
  /// Throws a [BreedImagesException] if the data cannot be fetched or
  /// if no images are found for the breed.
  Future<BreedImagesModel> getBreedImages(BreedType breed);

  /// Checks if breed images are cached locally.
  ///
  /// The [breed] parameter specifies which breed to check.
  ///
  /// Returns `true` if the breed images are available in the local cache,
  /// `false` otherwise.
  Future<bool> isBreedCached(BreedType breed);

  /// Gets cached breed images for offline viewing.
  ///
  /// The [breed] parameter specifies which breed's cached images to retrieve.
  ///
  /// Returns a [Future] that completes with a [BreedImagesModel] from the
  /// local cache, or `null` if no cached data exists.
  Future<BreedImagesModel?> getCachedBreedImages(BreedType breed);

  /// Caches breed images locally for offline viewing.
  ///
  /// The [breedImages] parameter contains the images to cache.
  ///
  /// This method implements the caching strategy defined in User Story 2,
  /// including LRU (Least Recently Used) cache management.
  Future<void> cacheBreedImages(BreedImagesModel breedImages);

  /// Clears all cached breed images.
  ///
  /// This method removes all cached image data from local storage,
  /// freeing up space as mentioned in the cache management requirements.
  Future<void> clearCache();

  /// Gets the current cache size in bytes.
  ///
  /// Returns the total size of cached image data.
  Future<int> getCacheSize();
}
