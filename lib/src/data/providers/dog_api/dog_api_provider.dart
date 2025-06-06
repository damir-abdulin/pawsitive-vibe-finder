import 'package:pawsitive_vibe_finder/src/data/entities/entities.dart';

/// An abstract interface for a provider that fetches dog data from the API.
abstract class DogApiProvider {
  /// Fetches a random dog from the API.
  Future<RandomDogEntity> getRandomDog();
}
