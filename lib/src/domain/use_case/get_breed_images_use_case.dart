import '../exceptions/breed_images_exception.dart';
import '../models/breed_images_model.dart';
import '../models/breed_type.dart';
import '../repository/breed_images_repository.dart';
import '../services/connectivity_service.dart';
import 'use_case.dart';

/// Input parameter for [GetBreedImagesUseCase].
class GetBreedImagesInput {
  /// The breed to fetch images for.
  final BreedType breed;

  /// Creates an instance of [GetBreedImagesInput].
  const GetBreedImagesInput({required this.breed});
}

/// Use case for fetching all images for a specific breed.
///
/// This use case implements the core functionality of User Story 2:
/// - Fetches breed images from the API when online
/// - Returns cached images when offline (if available)
/// - Handles the offline scenario with appropriate error handling
/// - Supports lazy loading and caching strategies
class GetBreedImagesUseCase
    extends FutureUseCase<GetBreedImagesInput, BreedImagesModel> {
  final BreedImagesRepository _breedImagesRepository;
  final ConnectivityService _connectivityService;

  /// Creates an instance of [GetBreedImagesUseCase].
  const GetBreedImagesUseCase({
    required BreedImagesRepository breedImagesRepository,
    required ConnectivityService connectivityService,
  }) : _breedImagesRepository = breedImagesRepository,
       _connectivityService = connectivityService;

  @override
  Future<BreedImagesModel> unsafeExecute(GetBreedImagesInput input) async {
    final bool isOnline = await _connectivityService.isConnected();

    if (isOnline) {
      // When online, fetch from API and cache the results
      final BreedImagesModel breedImages = await _breedImagesRepository
          .getBreedImages(input.breed);

      // Cache the images for offline use (fire and forget)
      unawaited(_breedImagesRepository.cacheBreedImages(breedImages));

      return breedImages;
    } else {
      // When offline, try to get cached images
      final BreedImagesModel? cachedImages = await _breedImagesRepository
          .getCachedBreedImages(input.breed);

      if (cachedImages != null) {
        return cachedImages;
      } else {
        // No cached data available and offline - this matches AC-9.2
        throw const BreedImagesException(
          message:
              'You are currently offline. Please connect to the internet to discover new pups!',
        );
      }
    }
  }
}

/// Helper function to schedule a future without waiting for it.
void unawaited(Future<void> future) {
  // This is used for fire-and-forget operations like caching
}
