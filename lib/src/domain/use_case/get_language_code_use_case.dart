import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for getting the saved language code.
class GetLanguageCodeUseCase extends FutureUseCase<void, String?> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [GetLanguageCodeUseCase].
  GetLanguageCodeUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<String?> unsafeExecute(void input) {
    return _preferencesRepository.getLanguageCode();
  }
}
