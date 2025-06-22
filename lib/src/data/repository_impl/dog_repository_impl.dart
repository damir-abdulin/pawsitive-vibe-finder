import '../../domain/domain.dart';
import '../entities/dog/dog_response_entity.dart';
import '../mappers/mappers.dart';
import '../providers/providers.dart';

/// The concrete implementation of the [DogRepository].
class DogRepositoryImpl implements DogRepository {
  final DogApiProvider _dogApiProvider;

  /// Creates an instance of [DogRepositoryImpl].
  const DogRepositoryImpl({required DogApiProvider dogApiProvider})
    : _dogApiProvider = dogApiProvider;

  @override
  Future<DogModel> getRandomDog() async {
    try {
      final DogResponseEntity randomDogEntity = await _dogApiProvider
          .getRandomDog();
      return DogResponseMapper.toDomain(randomDogEntity);
    } on NetworkException catch (e) {
      // Add context and rethrow as a domain-specific exception
      throw DogException(message: 'Failed to fetch dog from API: ${e.message}');
    } on ProviderException catch (e) {
      // Handle other provider errors
      throw DogException(
        message: 'An error occurred in the data provider: ${e.message}',
      );
    } catch (e) {
      // Handle unexpected errors
      throw DogException(message: 'An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<DogModel>> getRandomDogs(int count) async {
    return <DogModel>[for (int i = 0; i < count; i++) await getRandomDog()];
  }

  @override
  Future<DogModel> getRandomDogForBreed(BreedType breed) async {
    try {
      final String breedPath = BreedMapper.fromDomain(breed);
      final DogResponseEntity randomDogEntity = await _dogApiProvider
          .getRandomDogByBreedPath(breedPath: breedPath);
      return DogResponseMapper.toDomain(randomDogEntity);
    } on NetworkException catch (e) {
      // Add context and rethrow as a domain-specific exception
      throw DogException(
        message: 'Failed to fetch dog from API for breed $breed: ${e.message}',
      );
    } on ProviderException catch (e) {
      // Handle other provider errors
      throw DogException(
        message:
            'An error occurred in the data provider for breed $breed: ${e.message}',
      );
    } catch (e) {
      // Handle unexpected errors
      throw DogException(
        message: 'An unexpected error occurred for breed $breed: $e',
      );
    }
  }

  @override
  Future<List<DogModel>> getRandomDogsForBreed(
    int count,
    BreedType breed,
  ) async {
    return <DogModel>[
      for (int i = 0; i < count; i++) await getRandomDogForBreed(breed),
    ];
  }
}
