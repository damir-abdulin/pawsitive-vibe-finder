import '../domain.dart';

class SaveLastDogUseCase extends FutureUseCase<RandomDogModel, void> {
  final PreferencesRepository _preferencesRepository;

  SaveLastDogUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<void> unsafeExecute(RandomDogModel input) async {
    return _preferencesRepository.saveLastDog(input);
  }
}
