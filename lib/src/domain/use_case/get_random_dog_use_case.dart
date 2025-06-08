import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for fetching a random dog.
class GetRandomDogUseCase extends FutureUseCase<void, DogModel> {
  final DogRepository _dogRepository;

  /// Creates an instance of [GetRandomDogUseCase].
  GetRandomDogUseCase({required DogRepository dogRepository})
    : _dogRepository = dogRepository;

  @override
  Future<DogModel> unsafeExecute(void input) {
    return _dogRepository.getRandomDog();
  }
}
