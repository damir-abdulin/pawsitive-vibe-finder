import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for saving the selected language code.
class SaveLanguageCodeUseCase extends FutureUseCase<String, void> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [SaveLanguageCodeUseCase].
  SaveLanguageCodeUseCase({
    required PreferencesRepository preferencesRepository,
  }) : _preferencesRepository = preferencesRepository;

  @override
  Future<void> unsafeExecute(String input) {
    return _preferencesRepository.saveLanguageCode(input);
  }
}
