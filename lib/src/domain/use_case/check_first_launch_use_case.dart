import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for checking if it's the user's first launch.
class CheckFirstLaunchUseCase extends FutureUseCase<void, bool> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [CheckFirstLaunchUseCase].
  CheckFirstLaunchUseCase({
    required PreferencesRepository preferencesRepository,
  }) : _preferencesRepository = preferencesRepository;

  @override
  Future<bool> unsafeExecute(void input) {
    return _preferencesRepository.isFirstLaunch();
  }
}
