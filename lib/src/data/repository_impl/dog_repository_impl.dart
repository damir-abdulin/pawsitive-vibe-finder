import '../../domain/domain.dart';
import '../../domain/exceptions/dog_exception.dart';
import '../entities/random_dog/random_dog_entity.dart';
import '../mappers/mappers.dart';
import '../providers/providers.dart';

/// The concrete implementation of the [DogRepository].
class DogRepositoryImpl implements DogRepository {
  final DogApiProvider _dogApiProvider;

  /// Creates an instance of [DogRepositoryImpl].
  const DogRepositoryImpl({required DogApiProvider dogApiProvider})
    : _dogApiProvider = dogApiProvider;

  @override
  Future<RandomDogModel> getRandomDog() async {
    try {
      final RandomDogEntity randomDogEntity = await _dogApiProvider
          .getRandomDog();
      return RandomDogMapper.toDomain(randomDogEntity);
    } on NetworkException catch (e) {
      // Add context and rethrow as a domain-specific exception
      throw DogException('Failed to fetch dog from API: ${e.message}');
    } on ProviderException catch (e) {
      // Handle other provider errors
      throw DogException(
        'An error occurred in the data provider: ${e.message}',
      );
    } catch (e) {
      // Handle unexpected errors
      throw DogException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<RandomDogModel>> getRandomDogs(int count) async {
    return <RandomDogModel>[
      for (int i = 0; i < count; i++) await getRandomDog(),
    ];
  }
}
