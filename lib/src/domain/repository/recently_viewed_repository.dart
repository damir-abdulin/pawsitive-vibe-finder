import '../models/models.dart';

/// An abstract interface for a repository that manages the list of recently
/// viewed dog breeds.
///
/// This contract abstracts the storage mechanism for the user's viewing
/// history.
abstract class RecentlyViewedRepository {
  /// Adds a breed to the list of recently viewed items.
  ///
  /// The [breed] model contains the necessary information to be stored.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  /// Throws a [LocalStorageException] or similar [AppException] on failure.
  Future<void> addBreedToRecentlyViewed(BreedType breed);
}
