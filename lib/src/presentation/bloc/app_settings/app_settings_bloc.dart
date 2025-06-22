import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import 'app_settings_event.dart';
import 'app_settings_state.dart';

/// BLoC for managing app-level settings like theme and language.
class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  /// Creates an [AppSettingsBloc].
  AppSettingsBloc({
    required GetThemeModeUseCase getThemeModeUseCase,
    required SaveThemeModeUseCase saveThemeModeUseCase,
    required GetLanguageCodeUseCase getLanguageCodeUseCase,
    required SaveLanguageCodeUseCase saveLanguageCodeUseCase,
  }) : _getThemeModeUseCase = getThemeModeUseCase,
       _saveThemeModeUseCase = saveThemeModeUseCase,
       _getLanguageCodeUseCase = getLanguageCodeUseCase,
       _saveLanguageCodeUseCase = saveLanguageCodeUseCase,
       super(const AppSettingsInitial()) {
    on<LoadAppSettingsEvent>(_onLoadAppSettings);
    on<ChangeThemeModeEvent>(_onChangeThemeMode);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  final GetThemeModeUseCase _getThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;
  final GetLanguageCodeUseCase _getLanguageCodeUseCase;
  final SaveLanguageCodeUseCase _saveLanguageCodeUseCase;

  Future<void> _onLoadAppSettings(
    LoadAppSettingsEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    try {
      final ThemeMode themeMode = await _getThemeModeUseCase.execute(
        null,
        onError: (AppException _) => Future<ThemeMode>.value(ThemeMode.system),
      );

      final String? languageCode = await _getLanguageCodeUseCase.execute(
        null,
        onError: (AppException _) => Future<String?>.value(),
      );

      emit(
        AppSettingsLoaded(
          themeMode: themeMode,
          languageCode: languageCode ?? 'en',
        ),
      );
    } catch (e) {
      emit(
        const AppSettingsLoaded(
          themeMode: ThemeMode.system,
          languageCode: 'en',
        ),
      );
    }
  }

  Future<void> _onChangeThemeMode(
    ChangeThemeModeEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    final AppSettingsState currentState = state;
    if (currentState is AppSettingsLoaded) {
      try {
        await _saveThemeModeUseCase.execute(
          event.themeMode,
          onError: (AppException _) => Future<void>.value(),
        );

        emit(currentState.copyWith(themeMode: event.themeMode));
      } catch (e) {
        // In case of error, emit the current state to keep UI consistent
        emit(currentState);
      }
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    final AppSettingsState currentState = state;
    if (currentState is AppSettingsLoaded) {
      try {
        await _saveLanguageCodeUseCase.execute(
          event.languageCode,
          onError: (AppException _) => Future<void>.value(),
        );

        emit(currentState.copyWith(languageCode: event.languageCode));
      } catch (e) {
        // In case of error, emit the current state to keep UI consistent
        emit(currentState);
      }
    }
  }
}
