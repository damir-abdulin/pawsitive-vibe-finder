import 'package:pawsitive_vibe_finder/src/domain/repository/repository.dart';
import 'package:pawsitive_vibe_finder/src/domain/use_case/use_case.dart';

/// A use case for marking the first launch as completed.
class SetFirstLaunchCompletedUseCase extends FutureUseCase<void, void> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [SetFirstLaunchCompletedUseCase].
  SetFirstLaunchCompletedUseCase({
    required PreferencesRepository preferencesRepository,
  }) : _preferencesRepository = preferencesRepository;

  @override
  Future<void> unsafeExecute(void input) {
    return _preferencesRepository.setFirstLaunchCompleted();
  }
}
