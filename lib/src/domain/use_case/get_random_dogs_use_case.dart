import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for fetching a random dog.
class GetRandomDogsUseCase extends FutureUseCase<int, List<RandomDogModel>> {
  final DogRepository _dogRepository;

  /// Creates an instance of [GetRandomDogUseCase].
  GetRandomDogsUseCase({required DogRepository dogRepository})
    : _dogRepository = dogRepository;

  @override
  Future<List<RandomDogModel>> unsafeExecute(int input) {
    return _dogRepository.getRandomDogs(input);
  }
}
