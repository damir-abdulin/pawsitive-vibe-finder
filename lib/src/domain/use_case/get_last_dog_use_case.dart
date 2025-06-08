import '../models/models.dart';
import '../repository/repository.dart';
import 'use_cases.dart';

class GetLastDogUseCase extends FutureUseCase<void, DogModel?> {
  final PreferencesRepository _preferencesRepository;

  GetLastDogUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<DogModel?> unsafeExecute(void input) async {
    return _preferencesRepository.getLastDog();
  }
}
