import '../models/breed_model.dart';
import '../repository/breed_repository.dart';
import 'use_cases.dart';

/// A use case for getting the list of all dog breeds.
class GetBreedsUseCase extends FutureUseCase<void, List<BreedModel>> {
  final BreedRepository _breedRepository;

  /// Creates a [GetBreedsUseCase].
  GetBreedsUseCase({required BreedRepository breedRepository})
    : _breedRepository = breedRepository;

  @override
  Future<List<BreedModel>> unsafeExecute(void input) async {
    return _breedRepository.getBreeds();
  }
}
