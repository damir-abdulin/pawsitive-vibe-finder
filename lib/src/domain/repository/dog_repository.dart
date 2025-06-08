import '../models/models.dart';

/// An abstract interface for fetching dog-related data.
abstract class DogRepository {
  /// Fetches a random dog image and its breed.
  Future<RandomDogModel> getRandomDog();

  Future<List<RandomDogModel>> getRandomDogs(int count);
}
