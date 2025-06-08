import '../models/breed_type.dart';

/// A repository for fetching breed data.
abstract class BreedRepository {
  /// Fetches the list of all dog breeds.
  ///
  /// Returns a list of [BreedType].
  Future<List<BreedType>> getBreeds();
}
