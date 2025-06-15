import '../models/breed_image_model.dart';
import '../models/dog_model.dart';
import '../repository/favorites_repository.dart';
import 'use_case.dart';

/// Input parameter for [ToggleBreedImageFavoriteUseCase].
class ToggleBreedImageFavoriteInput {
  /// The breed image to toggle favorite status for.
  final BreedImageModel breedImage;

  /// Creates an instance of [ToggleBreedImageFavoriteInput].
  const ToggleBreedImageFavoriteInput({required this.breedImage});
}

/// Use case for toggling the favorite status of a breed image.
///
/// This use case handles the favoriting functionality mentioned in User Story 2:
/// - Toggles the favorite status of an image in the slideshow
/// - Persists the favorite state for the user
/// - Returns the updated image model with the new favorite status
class ToggleBreedImageFavoriteUseCase
    extends FutureUseCase<ToggleBreedImageFavoriteInput, BreedImageModel> {
  final FavoritesRepository _favoritesRepository;

  /// Creates an instance of [ToggleBreedImageFavoriteUseCase].
  const ToggleBreedImageFavoriteUseCase({
    required FavoritesRepository favoritesRepository,
  }) : _favoritesRepository = favoritesRepository;

  @override
  Future<BreedImageModel> unsafeExecute(
    ToggleBreedImageFavoriteInput input,
  ) async {
    final BreedImageModel updatedImage = input.breedImage.copyWith(
      isFavorite: !input.breedImage.isFavorite,
    );

    if (updatedImage.isFavorite) {
      // Save to favorites - convert to DogModel format that existing repository expects
      final DogModel dogModel = DogModel(
        imageUrl: updatedImage.imageUrl,
        breed: updatedImage.breed,
      );
      await _favoritesRepository.saveFavoriteDog(dogModel);
    } else {
      // Remove from favorites - convert to DogModel format
      final DogModel dogModel = DogModel(
        imageUrl: updatedImage.imageUrl,
        breed: updatedImage.breed,
      );
      await _favoritesRepository.removeFavoriteDog(dogModel);
    }

    return updatedImage;
  }
}
