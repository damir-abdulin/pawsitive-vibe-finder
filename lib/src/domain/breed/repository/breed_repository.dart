import '../models/breed_model.dart';

/// A repository for fetching breed data.
abstract class BreedRepository {
  /// Fetches the list of all dog breeds.
  ///
  /// Returns a list of [BreedModel].
  Future<List<BreedModel>> getBreeds();
}
