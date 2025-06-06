import 'package:pawsitive_vibe_finder/src/domain/repository/repository.dart';
import 'package:pawsitive_vibe_finder/src/domain/use_case/use_case.dart';

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
