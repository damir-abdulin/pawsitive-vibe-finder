import '../../domain/domain.dart';
import '../entities/breed_images/breed_images_response_entity.dart';
import '../mappers/breed_images_mapper.dart';
import '../mappers/breed_mapper.dart';
import '../providers/breed_images_cache_dao.dart';
import '../providers/exceptions/provider_exceptions.dart';
import '../providers/providers.dart';

/// The concrete implementation of [BreedImagesRepository].
///
/// This repository coordinates between API calls and local caching to provide
/// breed images with offline support as defined in User Story 2.
class BreedImagesRepositoryImpl implements BreedImagesRepository {
  final DogApiProvider _dogApiProvider;
  final BreedImagesCacheDao _cacheDao;
  final IsFavoriteDogUseCase _isFavoriteDogUseCase;

  /// Maximum cache size in bytes (250 MB as specified in User Story 2).
  static const int maxCacheSizeBytes = 250 * 1024 * 1024; // 250 MB

  /// Creates an instance of [BreedImagesRepositoryImpl].
  const BreedImagesRepositoryImpl({
    required DogApiProvider dogApiProvider,
    required BreedImagesCacheDao cacheDao,
    required IsFavoriteDogUseCase isFavoriteDogUseCase,
  }) : _dogApiProvider = dogApiProvider,
       _cacheDao = cacheDao,
       _isFavoriteDogUseCase = isFavoriteDogUseCase;

  @override
  Future<BreedImagesModel> getBreedImages(BreedType breed) async {
    try {
      // Convert breed to API path format
      final String breedPath = BreedMapper.fromDomain(breed);

      // Fetch from API
      final BreedImagesResponseEntity response = await _dogApiProvider
          .getBreedImages(breedPath);

      // Convert to domain model
      final BreedImagesModel breedImages = BreedImagesMapper.toDomain(
        entity: response,
        breed: breed,
      );

      // Check if we have any images
      if (!breedImages.hasImages) {
        throw const BreedImagesException(
          message:
              'No barks about it, we could not find any images for this breed!',
        );
      }

      // Load favorite status for each image
      final BreedImagesModel breedImagesWithFavorites =
          await _loadFavoriteStatus(breedImages);

      return breedImagesWithFavorites;
    } on NetworkException catch (e) {
      throw BreedImagesException(
        message:
            'Failed to load the gallery. Please check your connection and try again.',
        cause: e,
      );
    } on ProviderException catch (e) {
      throw BreedImagesException(
        message:
            'Failed to load the gallery. Please check your connection and try again.',
        cause: e,
      );
    } catch (e) {
      throw BreedImagesException(
        message: 'An unexpected error occurred while fetching breed images: $e',
        cause: e,
      );
    }
  }

  @override
  Future<bool> isBreedCached(BreedType breed) async {
    try {
      final String breedId = BreedMapper.fromDomain(breed);
      return await _cacheDao.isBreedCached(breedId);
    } catch (e) {
      // If cache check fails, assume not cached
      return false;
    }
  }

  @override
  Future<BreedImagesModel?> getCachedBreedImages(BreedType breed) async {
    try {
      final String breedId = BreedMapper.fromDomain(breed);
      final List<String>? cachedUrls = await _cacheDao.getCachedImageUrls(
        breedId,
      );

      if (cachedUrls != null && cachedUrls.isNotEmpty) {
        final BreedImagesModel breedImages = BreedImagesMapper.fromCachedUrls(
          imageUrls: cachedUrls,
          breed: breed,
        );

        // Load favorite status for cached images
        final BreedImagesModel breedImagesWithFavorites =
            await _loadFavoriteStatus(breedImages);
        return breedImagesWithFavorites;
      }

      return null;
    } catch (e) {
      // If cache retrieval fails, return null
      return null;
    }
  }

  @override
  Future<void> cacheBreedImages(BreedImagesModel breedImages) async {
    try {
      final String breedId = BreedMapper.fromDomain(breedImages.breed);
      final List<String> imageUrls = BreedImagesMapper.extractImageUrls(
        breedImages,
      );
      final int sizeInBytes = BreedImagesMapper.estimateCacheSizeBytes(
        imageUrls,
      );

      // Check if adding this cache would exceed the limit
      final int currentCacheSize = await _cacheDao.getTotalCacheSize();
      final int newTotalSize = currentCacheSize + sizeInBytes;

      if (newTotalSize > maxCacheSizeBytes) {
        // Evict least recently used entries to make space
        await _cacheDao.evictLeastRecentlyUsed(maxCacheSizeBytes - sizeInBytes);
      }

      // Save to cache
      await _cacheDao.saveBreedImages(
        breedId: breedId,
        imageUrls: imageUrls,
        sizeInBytes: sizeInBytes,
      );
    } catch (e) {
      // Cache failures should not prevent the main functionality
      // Log the error but don't throw (fire-and-forget operation)
      // In a real app, you might want to use a logger here
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _cacheDao.clearAllCache();
    } catch (e) {
      throw BreedImagesException(
        message: 'Failed to clear cache: $e',
        cause: e,
      );
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      return await _cacheDao.getTotalCacheSize();
    } catch (e) {
      // If cache size retrieval fails, return 0
      return 0;
    }
  }

  /// Loads the favorite status for each image in the collection.
  ///
  /// This method checks the favorites database to determine which images
  /// are marked as favorites and updates the BreedImagesModel accordingly.
  Future<BreedImagesModel> _loadFavoriteStatus(
    BreedImagesModel breedImages,
  ) async {
    try {
      final List<BreedImageModel> updatedImages = <BreedImageModel>[];

      for (final BreedImageModel image in breedImages.images) {
        // Convert to DogModel format for favorites check
        final DogModel dogModel = DogModel(
          imageUrl: image.imageUrl,
          breed: image.breed,
        );

        // Check if this image is favorited using the use case
        final bool isFavorite = await _isFavoriteDogUseCase.execute(
          dogModel,
          onError: (AppException exception) async => false,
        );

        // Update the image with the correct favorite status
        final BreedImageModel updatedImage = image.copyWith(
          isFavorite: isFavorite,
        );
        updatedImages.add(updatedImage);
      }

      return breedImages.copyWith(images: updatedImages);
    } catch (e) {
      // If favorite status loading fails, return the original images
      // This ensures the slideshow still works even if favorites are unavailable
      return breedImages;
    }
  }
}
