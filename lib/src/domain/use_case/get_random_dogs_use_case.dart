import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for fetching a random dog.
class GetRandomDogsUseCase
    extends FutureUseCase<(int, BreedType?), List<DogModel>> {
  final DogRepository _dogRepository;

  /// Creates an instance of [GetRandomDogUseCase].
  GetRandomDogsUseCase({required DogRepository dogRepository})
    : _dogRepository = dogRepository;

  @override
  Future<List<DogModel>> unsafeExecute((int, BreedType?) input) {
    final (int count, BreedType? breed) = input;

    return breed != null
        ? _dogRepository.getRandomDogsForBreed(count, breed)
        : _dogRepository.getRandomDogs(count);
  }
}
