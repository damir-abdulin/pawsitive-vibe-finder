import '../../entities/entities.dart';

/// An abstract interface for a provider that fetches dog data from the API.
abstract class DogApiProvider {
  /// Fetches a random dog from the API.
  Future<DogResponseEntity> getRandomDog();

  /// Fetches a random dog by breed path from the API.
  Future<DogResponseEntity> getRandomDogByBreedPath({
    required String breedPath,
  });

  /// Fetches breed images from the API.
  Future<BreedImagesResponseEntity> getBreedImages(String breedPath);
}
