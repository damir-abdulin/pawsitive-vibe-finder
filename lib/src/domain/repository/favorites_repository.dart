import 'package:pawsitive_vibe_finder/src/domain/models/models.dart';

/// An abstract interface for managing the user's favorite dogs.
abstract class FavoritesRepository {
  /// Saves a dog to the user's favorites.
  Future<void> saveFavoriteDog(RandomDogModel dog);
}
