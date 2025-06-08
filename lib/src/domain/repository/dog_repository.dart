import '../models/models.dart';

/// An abstract interface for fetching dog-related data.
abstract class DogRepository {
  /// Fetches a random dog image and its breed.
  Future<DogModel> getRandomDog();

  Future<List<DogModel>> getRandomDogs(int count);

  /// Fetches a random image for a specific breed.
  ///
  /// The [breedPath] corresponds to the `apiRequestPath` from a [BreedModel].
  ///
  /// Returns a [Future] that completes with a [DogImageModel] on success.
  /// Throws an [AppException] if the data cannot be fetched.
  Future<DogModel> getRandomDogForBreed(BreedType breed);

  Future<List<DogModel>> getRandomDogsForBreed(int count, BreedType breed);
}
