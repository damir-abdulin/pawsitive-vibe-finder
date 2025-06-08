import '../../domain/models/breed_type.dart';
import '../../domain/repository/breed_repository.dart';

/// An implementation of the [BreedRepository].
class BreedRepositoryImpl implements BreedRepository {
  /// Creates a [BreedRepositoryImpl].
  const BreedRepositoryImpl();

  @override
  Future<List<BreedType>> getBreeds() async {
    return BreedType.values;
  }
}
