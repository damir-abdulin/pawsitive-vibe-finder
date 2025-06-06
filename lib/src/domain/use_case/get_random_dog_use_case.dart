import 'package:pawsitive_vibe_finder/src/domain/models/models.dart';
import 'package:pawsitive_vibe_finder/src/domain/repository/repository.dart';
import 'package:pawsitive_vibe_finder/src/domain/use_case/use_case.dart';

/// A use case for fetching a random dog.
class GetRandomDogUseCase extends FutureUseCase<void, RandomDogModel> {
  final DogRepository _dogRepository;

  /// Creates an instance of [GetRandomDogUseCase].
  GetRandomDogUseCase({required DogRepository dogRepository})
    : _dogRepository = dogRepository;

  @override
  Future<RandomDogModel> unsafeExecute(void input) {
    return _dogRepository.getRandomDog();
  }
}
