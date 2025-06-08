import '../domain.dart';

class GetLastDogUseCase extends FutureUseCase<void, RandomDogModel?> {
  final PreferencesRepository _preferencesRepository;

  GetLastDogUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<RandomDogModel?> unsafeExecute(void input) async {
    return _preferencesRepository.getLastDog();
  }
}
