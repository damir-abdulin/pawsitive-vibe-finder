import '../../domain/exceptions/breed_exception.dart';
import '../../domain/models/breed_model.dart';
import '../../domain/repository/breed_repository.dart';
import '../entities/entities.dart';
import '../mappers/breed_mapper.dart';
import '../providers/breed_local/breed_local_provider.dart';

/// An implementation of the [BreedRepository].
class BreedRepositoryImpl implements BreedRepository {
  final BreedLocalProvider _breedLocalDataSource;

  /// Creates a [BreedRepositoryImpl].
  const BreedRepositoryImpl({required BreedLocalProvider breedLocalDataSource})
    : _breedLocalDataSource = breedLocalDataSource;

  @override
  Future<List<BreedModel>> getBreeds() async {
    try {
      final dynamic response = await _breedLocalDataSource.getBreeds();
      final BreedResponseEntity entity = BreedResponseEntity.fromJson(response);
      return BreedMapper.fromEntity(entity);
    } catch (e) {
      throw BreedException('An unknown error occurred: $e');
    }
  }
}
