import 'package:flutter/material.dart';

import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for getting the saved theme mode.
class GetThemeModeUseCase extends FutureUseCase<void, ThemeMode> {
  final PreferencesRepository _preferencesRepository;

  /// Creates an instance of [GetThemeModeUseCase].
  GetThemeModeUseCase({required PreferencesRepository preferencesRepository})
    : _preferencesRepository = preferencesRepository;

  @override
  Future<ThemeMode> unsafeExecute(void input) {
    return _preferencesRepository.getThemeMode();
  }
}
