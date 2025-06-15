import '../repository/breed_images_repository.dart';
import 'use_case.dart';

/// Input parameter for [ClearBreedImagesCacheUseCase].
class ClearBreedImagesCacheInput {
  /// Creates an instance of [ClearBreedImagesCacheInput].
  const ClearBreedImagesCacheInput();
}

/// Output model for [ClearBreedImagesCacheUseCase].
class ClearBreedImagesCacheOutput {
  /// The size of the cache that was cleared in bytes.
  final int clearedCacheSize;

  /// Creates an instance of [ClearBreedImagesCacheOutput].
  const ClearBreedImagesCacheOutput({required this.clearedCacheSize});
}

/// Use case for clearing all cached breed images.
///
/// This use case implements the cache management functionality from User Story 2:
/// - Clears all cached breed images from local storage
/// - Returns the amount of space freed up
/// - Provides the cache clearing functionality for the settings screen
class ClearBreedImagesCacheUseCase
    extends
        FutureUseCase<ClearBreedImagesCacheInput, ClearBreedImagesCacheOutput> {
  final BreedImagesRepository _breedImagesRepository;

  /// Creates an instance of [ClearBreedImagesCacheUseCase].
  const ClearBreedImagesCacheUseCase({
    required BreedImagesRepository breedImagesRepository,
  }) : _breedImagesRepository = breedImagesRepository;

  @override
  Future<ClearBreedImagesCacheOutput> unsafeExecute(
    ClearBreedImagesCacheInput input,
  ) async {
    // Get the current cache size before clearing
    final int cacheSize = await _breedImagesRepository.getCacheSize();

    // Clear the cache
    await _breedImagesRepository.clearCache();

    return ClearBreedImagesCacheOutput(clearedCacheSize: cacheSize);
  }
}
