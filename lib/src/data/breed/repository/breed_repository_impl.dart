import '../../../domain/breed/exceptions/exceptions.dart';
import '../../../domain/breed/models/models.dart';
import '../../../domain/breed/repository/repository.dart';
import '../entities/entities.dart';
import '../exceptions/breed_provider_exception.dart';
import '../mappers/mappers.dart';
import '../providers/providers.dart';

/// An implementation of the [BreedRepository].
class BreedRepositoryImpl implements BreedRepository {
  final BreedProvider _breedProvider;

  /// Creates a [BreedRepositoryImpl].
  const BreedRepositoryImpl({required BreedProvider breedProvider})
    : _breedProvider = breedProvider;

  @override
  Future<List<BreedModel>> getBreeds() async {
    try {
      final dynamic response = await _breedProvider.getBreeds();
      final BreedResponseEntity entity = BreedResponseEntity.fromJson(
        response.data,
      );
      return BreedMapper.fromEntity(entity);
    } on BreedProviderException catch (e) {
      throw BreedException(e.message);
    } catch (e) {
      throw BreedException('An unknown error occurred: $e');
    }
  }
}
