import 'package:pawsitive_vibe_finder/src/domain/models/models.dart';

/// An abstract interface for fetching dog-related data.
abstract class DogRepository {
  /// Fetches a random dog image and its breed.
  Future<RandomDogModel> getRandomDog();
}
