import '../repository/repository.dart';
import 'use_case.dart';

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
