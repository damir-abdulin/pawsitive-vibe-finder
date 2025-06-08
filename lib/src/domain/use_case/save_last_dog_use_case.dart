import '../models/models.dart';
import '../repository/repository.dart';
import 'use_cases.dart';

class SaveLastDogUseCase extends FutureUseCase<DogModel, void> {
  final PreferencesRepository _preferencesRepository;

  SaveLastDogUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<void> unsafeExecute(DogModel input) async {
    return _preferencesRepository.saveLastDog(input);
  }
}
