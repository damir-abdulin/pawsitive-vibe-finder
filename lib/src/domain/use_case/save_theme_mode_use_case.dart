import 'package:flutter/material.dart';

import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for saving the selected theme mode.
class SaveThemeModeUseCase extends FutureUseCase<ThemeMode, void> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [SaveThemeModeUseCase].
  SaveThemeModeUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<void> unsafeExecute(ThemeMode input) {
    return _preferencesRepository.saveThemeMode(input);
  }
}
