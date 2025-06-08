import '../../use_case/use_case.dart';
import '../models/breed_model.dart';
import '../repository/breed_repository.dart';

/// A use case for getting the list of all dog breeds.
class GetBreedsUseCase extends FutureUseCase<void, List<BreedModel>> {
  final BreedRepository _breedRepository;

  /// Creates a [GetBreedsUseCase].
  const GetBreedsUseCase({required BreedRepository breedRepository})
    : _breedRepository = breedRepository;

  @override
  Future<List<BreedModel>> unsafeExecute(void input) {
    return _breedRepository.getBreeds();
  }
}
