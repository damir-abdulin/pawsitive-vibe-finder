import 'package:pawsitive_vibe_finder/src/data/mappers/mappers.dart';
import 'package:pawsitive_vibe_finder/src/data/providers/providers.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/domain/exceptions/exceptions.dart';

/// The concrete implementation of the [DogRepository].
class DogRepositoryImpl implements DogRepository {
  final DogApiProvider _dogApiProvider;

  /// Creates an instance of [DogRepositoryImpl].
  const DogRepositoryImpl({required DogApiProvider dogApiProvider})
    : _dogApiProvider = dogApiProvider;

  @override
  Future<RandomDogModel> getRandomDog() async {
    try {
      final randomDogEntity = await _dogApiProvider.getRandomDog();
      return RandomDogMapper.toDomain(randomDogEntity);
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
      throw DogException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }
}
