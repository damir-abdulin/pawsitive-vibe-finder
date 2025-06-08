import '../models/models.dart';

/// An abstract interface for a repository that manages the user's favorite
/// images.
///
/// This contract decouples the domain layer from the specifics of how favorite
/// images are persisted (e.g., local database, remote server).
abstract class FavoritesRepository {
  /// Adds an image to the user's favorites.
  ///
  /// The [imageUrl] is the unique identifier for the image.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  /// Throws a [LocalStorageException] or similar [AppException] on failure.
  Future<void> saveFavoriteDog(DogModel dog);

  /// Retrieves a real-time list of all favorite dogs.
  ///
  /// Returns a [Stream] that emits a new list of [DogModel] whenever the
  /// collection of favorites changes.
  Stream<List<DogModel>> getFavoriteDogs();

  /// Removes a dog from the user's favorites.
  ///
  /// The [dog] to be removed.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  Future<void> removeFavoriteDog(DogModel dog);
}
